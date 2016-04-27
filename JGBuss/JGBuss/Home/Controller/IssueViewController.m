//
//  IssueViewController.m
//  JGBuss
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "IssueViewController.h"
#import "HistoryViewController.h"
#import "SavedModelController.h"
#import "IssuePartJobController.h"
#import "JGHTTPClient+IssuePartJob.h"
#import "PartTypeModel.h"
#import "CityModel.h"
#import "AreaModel.h"

@interface IssueViewController ()
@property (nonatomic,strong) NSMutableArray *cityModels;
@property (nonatomic,strong) NSMutableArray *areaModels;
@property (nonatomic,strong) NSMutableArray *jobTypes;
@end

@implementation IssueViewController

-(NSMutableArray *)cityModels
{
    if (!_cityModels) {
        _cityModels = [[NSMutableArray alloc] init];
    }
    return _cityModels;
}

-(NSMutableArray *)jobTypes
{
    if (!_jobTypes) {
        _jobTypes = [NSMutableArray array];
    }
    return _jobTypes;
}

-(NSMutableArray *)areaModels
{
    if (!_areaModels) {
        _areaModels = [NSMutableArray array];
    }
    return _areaModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发布兼职";
    self.view.backgroundColor = WHITECOLOR;
    [self configUI];
    
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

-(void)configUI
{
    UIButton *historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    historyBtn.tag = 100;
    historyBtn.frame = CGRectMake(45*Scale, 30, SCREEN_W-2*45*Scale, 90*Scale);
    [historyBtn setBackgroundColor:RGBCOLOR(255, 211, 129)];
    [historyBtn addTarget:self action:@selector(selecPartJob:) forControlEvents:UIControlEventTouchUpInside];
    [historyBtn setTitle:@"从历史记录中选取" forState:UIControlStateNormal];
    [self setCoroundLayer:historyBtn];
    [self.view addSubview:historyBtn];
    
    UIButton *moduleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moduleBtn.tag = 200;
    
    [moduleBtn addTarget:self action:@selector(selecPartJob:) forControlEvents:UIControlEventTouchUpInside];
    moduleBtn.frame = CGRectMake(45*Scale, historyBtn.bottom+30, SCREEN_W-2*45*Scale, 90*Scale);
    [moduleBtn setBackgroundColor:RGBCOLOR(255, 122, 104)];
    [moduleBtn setTitle:@"从已保存的模板中选取" forState:UIControlStateNormal];
    [self setCoroundLayer:moduleBtn];
    [self.view addSubview:moduleBtn];
    
    UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newBtn.tag = 300;
    [self setCoroundLayer:newBtn];
    [newBtn addTarget:self action:@selector(selecPartJob:) forControlEvents:UIControlEventTouchUpInside];
    newBtn.frame = CGRectMake(0, moduleBtn.bottom+80, SCREEN_W, 50*Scale);
    [newBtn setBackgroundColor:BACKCOLORGRAY];
    [newBtn setTitle:@"创建新的兼职" forState:UIControlStateNormal];
    [newBtn setTitleColor:LIGHTGRAYTEXT forState:UIControlStateNormal];
    [self.view addSubview:newBtn];

}

-(void)selecPartJob:(UIButton *)btn
{
    if (btn.tag == 100) {//点击从历史记录中选取
        
        HistoryViewController *histoyVC = [[HistoryViewController alloc] init];
        histoyVC.cityModels = self.cityModels;
        histoyVC.jobTypes = self.jobTypes;
        [self.navigationController pushViewController:histoyVC animated:YES];
        
    }else if (btn.tag == 200){//点击从模板中选取
        
        SavedModelController *modelVC = [[SavedModelController alloc] init];
        modelVC.cityModels = self.cityModels;
        modelVC.jobTypes = self.jobTypes;
        [self.navigationController pushViewController:modelVC animated:YES];
        
    }else if (btn.tag == 300){//点击创建新的兼职
        IssuePartJobController *issueVC = [[IssuePartJobController alloc] init];
//        issueVC.hidesBottomBarWhenPushed = YES;
        issueVC.cityModels = self.cityModels;
        issueVC.jobTypes = self.jobTypes;
        [self.navigationController pushViewController:issueVC animated:YES];
    }
}

-(void)setCoroundLayer:(UIButton *)btn
{
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
}

@end
