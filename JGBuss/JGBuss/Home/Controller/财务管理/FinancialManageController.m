//
//  FinancialManageController.m
//  JGBuss
//
//  Created by apple on 16/4/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FinancialManageController.h"
#import "JGHTTPClient+PayPassWord.h"

@interface FinancialManageController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPassWordTF;
@property (weak, nonatomic) IBOutlet UITextField *lastPassWordTF;
@property (weak, nonatomic) IBOutlet UITextField *surePassWordTF;

@end

@implementation FinancialManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"财务中心";
    
    self.oldPassWordTF.keyboardType = UIKeyboardTypeNumberPad;
    self.lastPassWordTF.keyboardType = UIKeyboardTypeNumberPad;
    self.surePassWordTF.keyboardType = UIKeyboardTypeNumberPad;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    btn.frame = CGRectMake(0, 0, 60, 30);
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sureAlertPW:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = bbi;
    
}

-(void)sureAlertPW:(UIButton *)btn
{
    if (![self.oldPassWordTF.text isEqualToString:USER.pay_password]) {
        [self showAlertViewWithText:@"输入的旧密码有误" duration:1];
        return;
    }
    if (![self.lastPassWordTF.text isEqualToString:self.surePassWordTF.text]) {
        [self showAlertViewWithText:@"两次输入的密码不一致" duration:1];
        return;
    }
    
    [JGHTTPClient alertPayPassWordByNewPassWord:self.surePassWordTF.text Id:USER.Id Success:^(id responseObject) {
        [self showAlertViewWithText:responseObject[@"message"] duration:1];
        if ([responseObject[@"code"] intValue] == 200) {
            JGUser *user = [JGUser user];
            user.pay_password = self.surePassWordTF.text;
            [JGUser saveUser:user WithDictionary:nil];
        }
    } failure:^(NSError *error) {
        [self showAlertViewWithText:NETERROETEXT duration:1];
    }];
}

@end
