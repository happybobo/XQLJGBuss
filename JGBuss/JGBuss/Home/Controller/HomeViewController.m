//
//  HomeViewController.m
//  JianGuo
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import "HomeViewController.h"
#import "FinancialManageController.h"
#import <Masonry/Masonry.h>
#import "ModuleView.h"
#import "ManageJobsController.h"
#import "IssueViewController.h"
#import "JGIMClient.h"
#import "JGHTTPClient+IssuePartJob.h"
#import "PartTypeModel.h"
#import "CityModel.h"
#import "AreaModel.h"

#define INSTANCE 40

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,AVIMClientDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *cityModelArr;
@property (nonatomic,strong) UIButton *cityBtn;

@property (nonatomic,strong) NSMutableArray *cityModels;
@property (nonatomic,strong) NSMutableArray *areaModels;
@property (nonatomic,strong) NSMutableArray *jobTypes;

@end

@implementation HomeViewController

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64)];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 49+64, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 110;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self configUI];
    
    //开启聊天客户端
    [self createAIMClient];
    
    [JGHTTPClient getAreaInfoByloginId:USER.login_id Success:^(id responseObject) {
        
        self.jobTypes = [PartTypeModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_type"]];
        self.cityModels = [CityModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_city2"]];
        CityModel *citymodel = self.cityModels[0];
        for (AreaModel *model in citymodel.list_t_area) {
            JGLog(@"%@",model.area_name);
        }
        
    } failure:^(NSError *error) {
        
    }];

}
/**
 *  开启聊天客户端
 */
-(void)createAIMClient
{
    self.client = [[JGIMClient shareJgIm] getAclient];
    self.client.delegate = self;
    [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            JGLog(@"客户端打开成功");
            [NotificationCenter postNotificationName:kNotificationOpenIMClient object:self.client];
        }
    }];
}
// 接收消息的回调函数
- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {
    JGLog(@"%@", message.text); // 耗子，起床！
    
    [NotificationCenter postNotificationName:kNotificationDidReceiveMessage object:message];
    
}

-(void)configUI
{
    JGLog(@"%f",SCREEN_H/568);
    //头部ImageView
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 150*(SCREEN_H/667))];
    imageView.image = [UIImage imageNamed:@"bg-chahua"];
    [self.view addSubview:imageView];

    ModuleView *issueView = [[ModuleView alloc] init];
    [issueView.btn addTarget:self action:@selector(issuePartJob:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:issueView];
    
    [issueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.view.mas_centerX).offset(-20);
        make.leading.mas_equalTo(self.view.mas_leading).offset(INSTANCE);
        make.top.mas_equalTo(imageView.mas_bottom).offset(INSTANCE);
        make.height.mas_equalTo(issueView.mas_width);
    }];
    
    ModuleView *managerView = [[ModuleView alloc] init];
    [managerView.btn addTarget:self action:@selector(managePartJob:) forControlEvents:UIControlEventTouchUpInside];
    managerView.backgroundColor = RGBCOLOR(43, 178, 230);
    managerView.label.text = @"管理兼职";
    managerView.iconName = @"icon_guanli";
    [self.view addSubview:managerView];
    [managerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view.mas_centerX).offset(20);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-INSTANCE);
        make.top.mas_equalTo(imageView.mas_bottom).offset(INSTANCE);
        make.height.mas_equalTo(managerView.mas_width);
    }];
    
    ModuleView *moneyView = [[ModuleView alloc] init];
    [moneyView.btn addTarget:self action:@selector(manageMoney:) forControlEvents:UIControlEventTouchUpInside];
    
    moneyView.backgroundColor = RGBCOLOR(49, 188, 155);
    moneyView.label.text = @"财务管理";
    moneyView.iconName = @"icon_money";
    [self.view addSubview:moneyView];
    [moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.view.mas_centerX).offset(-20);
        make.leading.mas_equalTo(self.view.mas_leading).offset(INSTANCE);
        make.top.mas_equalTo(issueView.mas_bottom).offset(INSTANCE);
        make.height.mas_equalTo(issueView.mas_width);
    }];
    
    ModuleView *mansourceView = [[ModuleView alloc] init];
    [mansourceView.btn addTarget:self action:@selector(mansourceCenter:) forControlEvents:UIControlEventTouchUpInside];
    mansourceView.backgroundColor = RGBCOLOR(252, 180, 95);
    mansourceView.label.text = @"人力中心";
    mansourceView.iconName = @"icon_geren";
    [self.view addSubview:mansourceView];
    [mansourceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view.mas_centerX).offset(20);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-INSTANCE);
        make.top.mas_equalTo(managerView.mas_bottom).offset(INSTANCE);
        make.height.mas_equalTo(mansourceView.mas_width);
    }];
}
#pragma mark 点击发布兼职的按钮
-(void)issuePartJob:(UIButton *)btn
{
    IssueViewController *issueVC = [[IssueViewController alloc] init];
    issueVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:issueVC animated:YES];
}
#pragma mark 点击管理兼职的按钮
-(void)managePartJob:(UIButton *)btn
{
    ManageJobsController *manageVC = [[ManageJobsController alloc] init];
    manageVC.cityModels = self.cityModels;
    manageVC.jobTypes = self.jobTypes;
    manageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:manageVC animated:YES];
}
#pragma mark 点击财务管理按钮
-(void)manageMoney:(UIButton *)btn
{
    FinancialManageController *financalVC = [[FinancialManageController alloc] init];
    financalVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:financalVC animated:YES];
}
#pragma mark 点击人力中心按钮
-(void)mansourceCenter:(UIButton *)btn
{

}


@end
