//
//  NavigatinViewController.m
//  JianGuo
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import "NavigatinViewController.h"

@interface NavigatinViewController ()<UIGestureRecognizerDelegate>

@end

@implementation NavigatinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BACKCOLORGRAY;
    [self.navigationItem setHidesBackButton:YES];
    [self customBackBtn];
    
}
/**
 *  自定义返回按钮
 */
-(void)customBackBtn
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.showsTouchWhenHighlighted = YES;
    backBtn.frame = CGRectMake(0, 0, 12, 21);
    [backBtn addTarget:self action:@selector(popToLoginVC) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"icon-back"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = item;
}

/**
 *  返回上一级页面
 */
-(void)popToLoginVC
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


@end
