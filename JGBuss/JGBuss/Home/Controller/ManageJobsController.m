//
//  ManageJobsController.m
//  JGBuss
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ManageJobsController.h"
#import "ManageDetailController.h"
#import "SelectView.h"
#import "ManageCell.h"
#import "ManagedModel.h"
#import "JGHTTPClient+ManageJob.h"

//类型枚举
typedef NS_ENUM(NSUInteger,TypeAdmitOrFinished)
{
    TypeOfAdmit = 1,
    TypeOfFinish = 2
};


@interface ManageJobsController ()<UITableViewDataSource,UITableViewDelegate>
{
    TypeAdmitOrFinished TYPEENUMREQUEST;
    int pageCount;
    UIView *bgView;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *modelArr;

@property (nonatomic,copy) NSString *type;;
@end

@implementation ManageJobsController

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 47, SCREEN_W, SCREEN_H-64-47)];
        _tableView.backgroundColor = BACKCOLORGRAY;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 150;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKCOLORGRAY;
    self.title = @"管理兼职";
    self.type = @"1";
    SelectView *selectView = [SelectView aSelectView];
    selectView.backgroundColor = WHITECOLOR;
    selectView.rightBtnBlock = ^(){//完成
        if (TYPEENUMREQUEST == TypeOfFinish) {
            return ;
        }
        TYPEENUMREQUEST = TypeOfFinish;
        self.type = @"0";
        [self requestList:@"0" type:self.type];
        
    };
    selectView.leftBtnBlock = ^(){//录取
        if (TYPEENUMREQUEST == TypeOfAdmit) {
            return ;
        }
        TYPEENUMREQUEST = TypeOfAdmit;
        self.type = @"1";
        [self requestList:@"0" type:self.type];
    };
    
    [self.view addSubview:selectView];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageCount = 0;
        [self requestList:@"0" type:self.type];
        
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        pageCount += 10;
        
        [self requestList:[NSString stringWithFormat:@"%d",pageCount] type:self.type];
        
        
    }];
    [self showANopartJobView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

-(void)requestList:(NSString *)count type:(NSString *)type
{
    JGSVPROGRESSLOAD(@"加载中...")
    [JGHTTPClient getManagedJobsListBymercntId:USER.Id count:count status:type Success:^(id responseObject) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        JGLog(@"%@",responseObject);
        
        if (count.intValue) {//下拉
            
            if ([[ManagedModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_job"]] count] == 0) {
                [self showAlertViewWithText:@"没有更多数据" duration:1];
                return ;
            }
            
            NSMutableArray *indexPaths = [NSMutableArray array];
            for (ManagedModel *model in [ManagedModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_job"]]) {
                [self.modelArr addObject:model];
                NSIndexPath* indexPath = [NSIndexPath indexPathForRow:self.modelArr.count-1 inSection:0];
                [indexPaths addObject:indexPath];
            }
            
            [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            return;

        }else{
            self.modelArr = [ManagedModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_job"]];
            if (self.modelArr.count == 0) {
                bgView.hidden = NO;
            }else{
                bgView.hidden = YES;
            }
        }
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
//        if ([[ManagedModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_job"]] count] == 0) {
//            [self showAlertViewWithText:@"没有更多数据" duration:1];
//            return ;
//        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *identifier = @"ManageCell";
//    ManageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!cell) {
    ManageCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ManageCell" owner:nil options:nil]lastObject];
//    }
    cell.model = self.modelArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManageDetailController *manageVC =[[ManageDetailController alloc] init];
    manageVC.title = [self.modelArr[indexPath.row] name];
    manageVC.manageModel = self.modelArr[indexPath.row];
    manageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:manageVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)showANopartJobView
{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_W, 250)];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(bgView.center.x-60, 0, 120, 120)];
    imgView.image = [UIImage imageNamed:@"nodata"];
    [bgView addSubview:imgView];
    
    UILabel *labelMiddle = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.bottom+5, SCREEN_W, 25)];
    labelMiddle.text = @"当前没有数据哦!";
    labelMiddle.font = FONT(16);
    labelMiddle.textColor = LIGHTGRAYTEXT;
    labelMiddle.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:labelMiddle];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"去找工作" forState:UIControlStateNormal];
    [btn setTitleColor:BLUECOLOR forState:UIControlStateNormal];
    btn.frame = CGRectMake(bgView.center.x-50, labelMiddle.bottom, 100, 30);
//    [btn addTarget:self action:@selector(gotoPartJobVC:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = FONT(16);
//    [bgView addSubview:btn];
    [self.view addSubview:bgView];
    bgView.hidden = YES;
}


@end
