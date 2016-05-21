//
//  MineViewController.m
//  JianGuo
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "JPUSHService.h"
#import "CoreLaunchCool.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImageView *iconView;

@end

@implementation MineViewController

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H+20)];
        _tableView.backgroundColor = BACKCOLORGRAY;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = nil;
        _tableView.rowHeight = 45;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
//    [self.view addSubview:self.tableView];
//    [self setnavigationBarButton];
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    logoutBtn.backgroundColor = YELLOWCOLOR;
    [logoutBtn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    logoutBtn.frame = CGRectMake(50, SCREEN_H/2-25, SCREEN_W-100, 50);
    [self.view addSubview:logoutBtn];
}
/**
 *  设置导航条上的按钮
 */
-(void)setnavigationBarButton
{
    UIButton *btn_r = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_r setBackgroundImage:[UIImage imageNamed:@"icon_message"] forState:UIControlStateNormal];
    [btn_r addTarget:self action:@selector(ClickMessage) forControlEvents:UIControlEventTouchUpInside];
    btn_r.frame = CGRectMake(0, 0, 19, 14);
    //提醒按钮
    self.msgRemindView = [[UIView alloc] initWithFrame:CGRectMake(btn_r.right-2, -2, 5, 5)];
    self.msgRemindView.backgroundColor = [UIColor redColor];
    self.msgRemindView.layer.masksToBounds = YES;
    self.msgRemindView.layer.cornerRadius = 2;
    [btn_r addSubview:self.msgRemindView];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn_r];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]};
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
//    [self.navigationController.navigationBar setTranslucent:YES];
//    [self.tableView reloadData];
}

#pragma mark  tableView 的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    return cell;
}

-(void)logout:(UIButton *)btn
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定退出登录?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAC = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sureAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AVIMClient *client = [[JGIMClient shareJgIm] getAclient];
        [client closeWithCallback:^(BOOL succeeded, NSError *error) {
            
        }];
        [[JGIMClient shareJgIm] setNull];
        
        [JGUser deleteuser];
        [JPUSHService setTags:nil alias:@"" fetchCompletionHandle:nil];
//        [NotificationCenter postNotificationName:kNotificationLogoutSuccessed object:client];
        //退到登录页面
        APPLICATION.keyWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init] ];
    }];
    [alertVC addAction:cancelAC];
    [alertVC addAction:sureAC];
    [self presentViewController:alertVC animated:YES completion:nil];
}



@end
