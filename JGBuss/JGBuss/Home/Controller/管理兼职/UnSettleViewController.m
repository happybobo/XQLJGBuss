//
//  UnSettleViewController.m
//  JGBuss
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UnSettleViewController.h"

@interface UnSettleViewController ()
@property (weak, nonatomic) IBOutlet UIButton *continueSettleBtn;

@property (weak, nonatomic) IBOutlet UILabel *countL;
@end

@implementation UnSettleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.countL.text = [NSString stringWithFormat:@"还有%@人未结算,是否继续结算?",self.count];
    self.title = @"结算成功";
}
- (IBAction)continueSettle:(UIButton *)sender {
    
    if (self.refreshBlock) {
        self.refreshBlock();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)popToLoginVC
{
    [self continueSettle:nil];
}

@end
