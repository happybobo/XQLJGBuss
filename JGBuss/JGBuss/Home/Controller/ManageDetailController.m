//
//  MangeDetailController.m
//  JGBuss
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ManageDetailController.h"
#import "JGHTTPClient+ManageJob.h"
#import "IssuePartJobController.h"
#import "DetailModel.h"
#import "MerchantModel.h"
#import "BottomBarView.h"
#import "DetailHeadCell.h"
#import "DetailsCell.h"
#import "WorkDetailCell.h"
#import "DetailListViewController.h"
#import "SettleViewController.h"
#import "QLAlertView.h"

@interface ManageDetailController ()<UITableViewDataSource,UITableViewDelegate,ClickBottomBtnDelegate,ClickManCountDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *modelArr;
@property (nonatomic,strong) DetailModel *detailModel;
@property (nonatomic,strong) MerchantModel *merchantModel;
@property (nonatomic,strong) UILabel *moneyL;
@end

@implementation ManageDetailController

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64-49) style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, -50, 0);
        _tableView.backgroundColor = BACKCOLORGRAY;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKCOLORGRAY;
    [self.view addSubview:self.tableView];
    
    if (self.manageModel.status.intValue == 3) {//去结算
        
        UIButton *settleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        settleBtn.frame = CGRectMake(0, SCREEN_H-49-64, SCREEN_W, 49);
        [self.view addSubview:settleBtn];
        [settleBtn setTitle:@"去结算" forState:UIControlStateNormal];
        [settleBtn setBackgroundColor:YELLOWCOLOR];
        [settleBtn addTarget:self action:@selector(gotoSettle:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        BottomBarView *barView = [[BottomBarView alloc] initWithFrame:CGRectMake(0, SCREEN_H-49-64, SCREEN_W, 49)];
        
        barView.backgroundColor = WHITECOLOR;
        barView.delegate = self;
        [barView.previewBtn setTitle:@"修改" forState:UIControlStateNormal];
        [barView.saveTptBtn setTitle:@"结束" forState:UIControlStateNormal];
        [barView.issueJobBtn setTitle:@"下架" forState:UIControlStateNormal];
        [self.view addSubview:barView];
    }

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    JGSVPROGRESSLOAD(@"加载中...")
    IMP_BLOCK_SELF(ManageDetailController);
    [JGHTTPClient lookPartJobsDetailsByJobid:self.manageModel.id merchantId:self.manageModel.merchant_id loginId:USER.login_id alike:self.manageModel.alike Success:^(id responseObject) {
        [SVProgressHUD dismiss];
        JGLog(@"%@",responseObject);
        if (responseObject) {
            if ([responseObject[@"code"] integerValue]==200) {
                
                block_self.detailModel = [DetailModel mj_objectWithKeyValues:[[responseObject objectForKey:@"data"] objectForKey:@"t_job_info"]];
                
                
                block_self.merchantModel = [MerchantModel mj_objectWithKeyValues:[[responseObject objectForKey:@"data"] objectForKey:@"t_merchant"]];
                [block_self.tableView reloadData];
            }
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            
            return 150;
            
            break;
        } case 1:{
            
            return 238;
            
            break;
        } case 2:{
            
            return 220;
            
            break;
        } case 3:{
            
            return 80;
            
            break;
        }
        default:
            return 0;
            break;
    }

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 12)];
    headerView.backgroundColor = BACKCOLORGRAY;
    return headerView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            
            DetailHeadCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailHeadCell" owner:nil options:nil]lastObject];
            cell.delegate = self;
            cell.manageModel = self.manageModel;
            cell.detailModel = self.detailModel;
            self.moneyL = cell.moneyL;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
            break;
        } case 1:{
            
            DetailsCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailsCell" owner:nil options:nil]lastObject];
            cell.model = self.detailModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
            break;
        } case 2:{
            
            WorkDetailCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"WorkDetailCell" owner:nil options:nil]lastObject];
            cell.model = self.detailModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
            break;
        } case 3:{
            
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = BACKCOLORGRAY;
//            UIButton *exportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [exportBtn setBackgroundColor:WHITECOLOR];
//            exportBtn.frame = CGRectMake(50, 10, SCREEN_W-100, 40);
//            [exportBtn setTitle:@"导出已录取的用户信息" forState:UIControlStateNormal];
//            [exportBtn setTitleColor:LIGHTGRAYTEXT forState:UIControlStateNormal];
//            [exportBtn addTarget:self action:@selector(exportData:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.contentView addSubview:exportBtn];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            break;
        }
        default:
            return nil;
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 导出数据
-(void)exportData:(UIButton *)btn
{
    
}

#pragma mark 点击修改
-(void)previewAPartJobDetail
{
    [QLAlertView showAlertTittle:@"确定修改?" message:nil compeletBlock:^{
        
        IssuePartJobController *issueVC = [[IssuePartJobController alloc] init];
        issueVC.jobId = self.manageModel.id;
        issueVC.isAlert = YES;
        
        [JGHTTPClient getAjobModelByjobId:self.manageModel.id Success:^(id responseObject) {
            if ([responseObject[@"message"] isEqualToString:@"工作已开始，不能修改该兼职"]) {
                [self showAlertViewWithText:responseObject[@"message"] duration:1];
                return ;
            }
            HistoryModel *model = [HistoryModel mj_objectWithKeyValues:[responseObject[@"data"] objectForKey:@"t_job"] ];
            issueVC.model = model;
            issueVC.cityModels = self.cityModels;
            issueVC.jobTypes = self.jobTypes;
            [self.navigationController pushViewController:issueVC animated:YES];
            
        } failure:^(NSError *error) {
            [self.navigationController pushViewController:issueVC animated:YES];
        }];
        
    }];
    

}
#pragma mark 点击结束
-(void)saveForModule
{
    [QLAlertView showAlertTittle:@"确定结束?" message:nil compeletBlock:^{
        [JGHTTPClient changeJobStausByjobId:self.manageModel.id offer:@"9" alike:self.manageModel.alike Success:^(id responseObject) {
            JGLog(@"%@",responseObject);
            [self showAlertViewWithText:responseObject[@"message"] duration:1];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        } failure:^(NSError *error) {
            JGLog(@"%@",error);
            [self showAlertViewWithText:NETERROETEXT duration:1];
        }];
    }];
    
}
#pragma mark 点击下架
-(void)issueAPartJob
{
    [QLAlertView showAlertTittle:@"确定下架?" message:nil compeletBlock:^{
        [JGHTTPClient changeJobStausByjobId:self.manageModel.id offer:@"13" alike:self.manageModel.alike Success:^(id responseObject) {
            JGLog(@"%@",responseObject);
            [self showAlertViewWithText:responseObject[@"message"] duration:1];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        } failure:^(NSError *error) {
            JGLog(@"%@",error);
            [self showAlertViewWithText:NETERROETEXT duration:1];
        }];

    }];
}
/**
 *  点击女生部分
 */
-(void)clickGirlBtn
{
    DetailListViewController *detailListVC = [[DetailListViewController alloc] init];
    detailListVC.title = @"报名列表";
    detailListVC.jobId = self.detailModel.nv_job_id;
    detailListVC.manageModel = self.manageModel;
    [self.navigationController pushViewController:detailListVC animated:YES];
}
/**
 *  点击男生部分
 */
-(void)clickBoyBtn
{
    DetailListViewController *detailListVC = [[DetailListViewController alloc] init];
    detailListVC.title = @"报名列表";
    detailListVC.jobId = self.manageModel.id;
    detailListVC.manageModel = self.manageModel;
    [self.navigationController pushViewController:detailListVC animated:YES];
}
/**
 *  点击总人数
 */
-(void)clickOneBtn
{
    DetailListViewController *detailListVC = [[DetailListViewController alloc] init];
    detailListVC.title = @"报名列表";
    detailListVC.jobId = self.manageModel.id;
    detailListVC.manageModel = self.manageModel;
    [self.navigationController pushViewController:detailListVC animated:YES];
}

#pragma mark 去结算
-(void)gotoSettle:(UIButton *)btn
{
    SettleViewController *settleVC = [[SettleViewController alloc] init];
    settleVC.jobId = self.manageModel.id;
    if (self.detailModel.nv_job_id) {
        settleVC.nvJobId = self.detailModel.nv_job_id;
    }else{
        settleVC.nvJobId = @"0";
    }
    settleVC.money = self.moneyL.text;
    settleVC.model = self.manageModel;
    [self.navigationController pushViewController:settleVC animated:YES];
}


@end
