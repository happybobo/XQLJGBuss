//
//  BaseViewController.m
//  JianGuo
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import "BaseViewController.h"
#import "DMAlertView.h"
#import "MobClick.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>
{
    UISwipeGestureRecognizer *_swipeGestureRecognizer;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [self.view addGestureRecognizer:_swipeGestureRecognizer];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = self;
    
    self.view.backgroundColor = BACKCOLORGRAY;
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    self.view.backgroundColor = BACKCOLORGRAY;
    //    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]};
    CGFloat top = 5;
    CGFloat bottom = 5 ;
    CGFloat left = 0;
    CGFloat right = 0;
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"icon-navigationBar"] resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
}

/**
 *  页面即将出现方法
 */
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}
/**
 *  页面即将消失方法
 */
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

- (void)showErrorViewWithText:(NSString *)text {
    DMAlertView *hud = nil;
    hud = [[DMAlertView alloc] initWithView:self.view];
    [self.view addSubview:hud];
    [hud showText:text];
}
- (void)showAlertViewWithText:(NSString *)text duration:(NSTimeInterval)duration {
    DMAlertView *hud = nil;
    hud = [[DMAlertView alloc] initWithView:self.view];
    [self.view addSubview:hud];
    [hud showText:text duration:duration];
}


#pragma 正则匹配手机号
- (BOOL)checkTelNumber:(NSString*) phoneNum

{
    phoneNum = [phoneNum stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *pattern =@"^1+[3578]+\\d{9}";
    
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:phoneNum];
    
    return isMatch;
    
}
- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
//截屏代码
-(UIImage *)ShootmeDidSuccessful{
    //首先开启上下文
    CGSize  imageSize = self.view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    //将某个VIew的所有内容渲染到图形的上下文中
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    //获得图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
}

@end
