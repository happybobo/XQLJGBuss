//
//  SavedModelController.m
//  JGBuss
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SavedModelController.h"
#import "IssuePartJobController.h"
#import "JGHTTPClient+IssuePartJob.h"
#import "HistryCell.h"

@interface SavedModelController()<UITableViewDataSource,UITableViewDelegate,ModelCellDelegate>
{
    int pageCount;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *modelArr;
@end

@implementation SavedModelController

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 98;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title = @"保存的模板";
    
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = BACKCOLORGRAY;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageCount = 0;
        [self requestModelList:@"0"];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        pageCount += 10;
        NSString *count = [NSString stringWithFormat:@"%d",pageCount];
        [self requestModelList:count];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)requestModelList:(NSString *)count
{
    JGSVPROGRESSLOAD(@"加载中...");
    [JGHTTPClient getHistoryOrModelJobListBymercntId:USER.Id type:@"1" count:count Success:^(id responseObject) {
        JGLog(@"%@",responseObject);
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([[HistoryModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_job"]] count] == 0) {
            [self showAlertViewWithText:@"没有更多数据" duration:1];
            return ;
        }
        if (count.intValue!=0) {//下拉
//            [self.modelArr addObjectsFromArray:[HistoryModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_job"]]];
            NSMutableArray *indexPaths = [NSMutableArray array];
            for (HistoryModel *model in [HistoryModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_job"]]) {
                [self.modelArr addObject:model];
                NSIndexPath* indexPath = [NSIndexPath indexPathForRow:self.modelArr.count-1 inSection:0];
                [indexPaths addObject:indexPath];
            }
            
            [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            return;
        }else{
            self.modelArr = [HistoryModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_job"]];
        }
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"HistoryCell";
    HistryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HistryCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.useBtn.hidden = NO;
    cell.cancelBtn.hidden = NO;
    cell.delegate = self;
    cell.historyModel = self.modelArr[indexPath.row];
    return cell;
}

-(void)useTheModel:(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)[[[btn superview] superview]superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    IssuePartJobController *issueVC = [[IssuePartJobController alloc] init];
    issueVC.model = self.modelArr[indexPath.row];
    issueVC.cityModels = self.cityModels;
    issueVC.jobTypes = self.jobTypes;
    issueVC.refreshBlock = ^(){
        [self requestModelList:@"0"];
    };
    [self.navigationController pushViewController:issueVC animated:YES];
}

-(void)deleteTheModel:(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)[[[btn superview] superview]superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    HistoryModel *model = self.modelArr[indexPath.row];
    [JGHTTPClient deleteTheModelByjobId:model.id mercntId:model.merchant_id Success:^(id responseObject) {
        
        JGLog(@"%@",responseObject);
        if ([responseObject[@"code"] intValue]) {
            [self.modelArr removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

@end
