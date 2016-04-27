//
//  AlertWageController.m
//  JGBuss
//
//  Created by apple on 16/4/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AlertWageController.h"
#import "UITextView+placeholder.h"
#import "UIImageView+WebCache.h"

@interface AlertWageController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *telL;
/**
 *  应发工资label
 */
@property (weak, nonatomic) IBOutlet UILabel *moneyL;
/**
 *  应发工资textF
 */
@property (weak, nonatomic) IBOutlet UITextField *waveL;
/**
 *  实发工资textF
 */
@property (weak, nonatomic) IBOutlet UITextField *commissionL;

@property (weak, nonatomic) IBOutlet UITextView *remarkTF;
@property (weak, nonatomic) IBOutlet UIButton *sureAlertBtn;

@end

@implementation AlertWageController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = WHITECOLOR;
    self.title = @"修改工资";
    self.remarkTF.placeholder = @"请输入备注信息";
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.model.name_image] placeholderImage:[UIImage imageNamed:@"icon_touxiang"]];
    if (self.model.tel.intValue != 0) {
        self.telL.text = self.model.tel;
    }
    if (self.model.realname.intValue != 0) {
        self.nameL.text = self.model.realname;
    }
    self.waveL.text = [self.model.real_money stringByAppendingString:@""];
    self.waveL.enabled = NO;
    self.moneyL.text = [self.model.real_money stringByAppendingString:@""];
    self.commissionL.keyboardType = UIKeyboardTypeNumberPad;
    if (self.model.remark) {
        self.remarkTF.placeholder = @"";
        self.remarkTF.text = self.model.remark;
    }
}

- (IBAction)sureAlert:(UIButton *)sender {
    
    if (self.alertBlock) {
        self.alertBlock(self.commissionL.text,self.remarkTF.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end
