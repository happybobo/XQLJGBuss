//
//  MyTabBarController.m
//  JianGuo
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import "MyTabBarController.h"
#import "MineViewController.h"
#import "HomeViewController.h"
#import "MessageListController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setChildController];
    
}

-(void)setChildController
{
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.title = @"首页";
    //设置图标
//    homeVC.tabBarItem.badgeValue = @"2";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"zh_sy"];
    //选中图标样式  修改渲染模式
    homeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"xz_sy"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navHome = [[UINavigationController alloc] initWithRootViewController:homeVC];
    navHome.tabBarItem.title = @"兼职中心";
    
    
    MessageListController *messageVC = [[MessageListController alloc] init];
    messageVC.title = @"消息";
    //设置图标
    messageVC.tabBarItem.image = [UIImage imageNamed:@"zh_lt"];
    //选中图标样式  修改渲染模式
    messageVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"xz_lt"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navMessageVC = [[UINavigationController alloc] initWithRootViewController:messageVC];
    navMessageVC.tabBarItem.title = @"消息";
    
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    mineVC.title = @"我的";
    //设置图标
    mineVC.tabBarItem.image = [UIImage imageNamed:@"zh_wd"];
    //选中图标样式  修改渲染模式
    mineVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"xz_wd"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navMine = [[UINavigationController alloc] initWithRootViewController:mineVC];
    navMine.tabBarItem.title = @"我的";
    
    
    [self addChildViewController:navHome];
//    [self addChildViewController:navMessageVC];
    [self addChildViewController:navMine];
    
    self.tabBar.tintColor = RGBCOLOR(59, 155, 255);
}

@end
