//
//  DetailListViewController.m
//  JGBuss
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DetailListViewController.h"
#import "JGHTTPClient+ManageJob.h"
#import "DetailListCell.h"
#import "PartJobSelectView.h"
#include "LibXL/libxl.h"

//报名状态枚举
typedef NS_ENUM(NSUInteger,SignUpType)
{
    SigndType = 1,
    AdmittedType= 2,
    CanceldType = 3
};


@interface DetailListViewController ()<UITableViewDataSource,UITableViewDelegate,ClickCancelBtnDeleagte,UIDocumentInteractionControllerDelegate>
{
    SignUpType TYPE;
    int pageCount;
    PartJobSelectView *selectView;
    UIView *bgView;
    UIDocumentInteractionController *docuC;
    
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *modelArr;

@property (nonatomic,copy) NSString *type;


@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *middleBtn;
@property (nonatomic,strong) UIButton *rightBtn;

@end

@implementation DetailListViewController

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
    self.type = @"0";
    selectView = [PartJobSelectView aSelectView];
    self.leftBtn = selectView.leftBtn;
    self.middleBtn = selectView.middleBtn;
    self.rightBtn = selectView.rightBtn;
    selectView.backgroundColor = WHITECOLOR;
    IMP_BLOCK_SELF(DetailListViewController);
    selectView.leftBtnBlock = ^(){//左边按钮
        TYPE = SigndType;
        block_self.type = @"0";
        [block_self requestList:@"0" type:block_self.type];
    };
    
    selectView.middleBtnBlock = ^(){//中间按钮
        TYPE = AdmittedType;
        block_self.type = @"1";
        [block_self requestList:@"0" type:block_self.type];
    };
    
    selectView.rightBtnBlock = ^(){//右边按钮
        TYPE =  CanceldType;
        block_self.type = @"2";
        [block_self requestList:@"0" type:block_self.type];
    };
    [self.view addSubview:selectView];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{//上拉刷新
        pageCount = 0;
        [self requestList:@"0" type:self.type];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{//上拉加载
        pageCount += 10;
        
        [self requestList:[NSString stringWithFormat:@"%d",pageCount] type:self.type];
    }];
    [self.tableView.mj_header beginRefreshing];
    [self showANopartJobView];
    
    UIButton *exportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    exportBtn.frame = CGRectMake(0, 0, 50, 30);
    [exportBtn setTitle:@"导出" forState:UIControlStateNormal];
    exportBtn.showsTouchWhenHighlighted = YES;
    [exportBtn addTarget:self action:@selector(exportUserData) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:exportBtn];
    self.navigationItem.rightBarButtonItem = item;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)requestList:(NSString *)count type:(NSString *)type
{
    JGSVPROGRESSLOAD(@"加载中...");
    [JGHTTPClient getSigndUpListByJobid:self.jobId count:count type:type Success:^(id responseObject) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        
        if (count.intValue) {//下拉
            
            if ([[SignModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_user_info"]] count] == 0) {
                [self showAlertViewWithText:@"没有更多数据" duration:1];
                return ;
            }
            NSMutableArray *indexPaths = [NSMutableArray array];
            for (SignModel *model in [SignModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_user_info"]]) {
                [self.modelArr addObject:model];
                NSIndexPath* indexPath = [NSIndexPath indexPathForRow:self.modelArr.count-1 inSection:0];
                [indexPaths addObject:indexPath];
            }
            
            [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            return;
            
        }else{
            self.modelArr = [SignModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_user_info"]];
            if (self.modelArr.count == 0) {
                bgView.hidden = NO;
            }else{
                bgView.hidden = YES;
            }
        }
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        if ([[SignModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_user_info"]] count] == 0) {
//            [self showAlertViewWithText:@"没有更多数据" duration:1];
            return ;
        }
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
//    static NSString *identifier = @"DetailListCell";
//    DetailListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!cell) {
    DetailListCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailListCell" owner:nil options:nil]lastObject];
//    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.model = self.modelArr[indexPath.row];
    return cell;
}

/**
 *  点击左边按钮
 */
-(void)clickLeftBtn:(UIButton *)btn
{
    DetailListCell *cell = (DetailListCell *)[[[btn superview] superview]superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    SignModel *model = self.modelArr[indexPath.row];
    int status = model.user_status.intValue;
    
    if (self.type.intValue == 0) {//已报名
       
        if (status == 0) {
            [self changeStatus:@"2" jobId:self.jobId loginId:model.login_id];
        }
        
    }else if (self.type.intValue == 1){//已录取
        
        if(status == 3){
            [self changeStatus:@"2" jobId:self.jobId loginId:model.login_id];
        }else if (status == 5){
            [self changeStatus:@"7" jobId:self.jobId loginId:model.login_id];
        }
        
        
    }else if (self.type.intValue == 2){//已取消
    
    }
    
}
/**
 *  点击右边按钮
 */
-(void)clickRightBtn:(UIButton *)btn
{
    DetailListCell *cell = (DetailListCell *)[[[btn superview] superview]superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    SignModel *model = self.modelArr[indexPath.row];
    int status = model.user_status.intValue;
    
    if (self.type.intValue == 0) {//已报名
        
        if (status == 0) {
            [self changeStatus:@"3" jobId:self.jobId loginId:model.login_id];
        }
        
    }else if (self.type.intValue == 1){//已录取
        return;
        
    }else if (self.type.intValue == 2){//已取消
        return;
    }
}

/** 改变状态接口 */
-(void)changeStatus:(NSString *)currentStatus jobId:(NSString *)jobId loginId:(NSString *)loginId
{
    [JGHTTPClient changeStausByjobId:jobId loginId:loginId offer:currentStatus Success:^(id responseObject) {
        JGLog(@"%@",responseObject);
        [self showAlertViewWithText:responseObject[@"message"] duration:1];
        [self requestList:@"0" type:self.type];
    } failure:^(NSError *error) {
        JGLog(@"%@",error);
    }];
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

-(void)exportUserData
{
    if (!self.modelArr.count) {
        [self showAlertViewWithText:@"没有可导出数据" duration:1];
        return;
    }
    //导出数据
    
    BookHandle book = xlCreateBook(); // use xlCreateXMLBook() for working with xlsx files
    
    SheetHandle sheet = xlBookAddSheet(book, "Sheet1", NULL);
    //第一个参数代表插入哪个表，第二个是第几行（默认从0开始），第三个是第几列（默认从0开始）
    xlSheetWriteStr(sheet, 1, 0, "姓名", 0);
    xlSheetWriteStr(sheet, 1, 1, "性别", 0);
    xlSheetWriteStr(sheet, 1, 2, "学校", 0);
    xlSheetWriteStr(sheet, 1, 3, "电话", 0);
    
    
    for (int i = 0; i < self.modelArr.count; i++) {
        SignModel *model = self.modelArr[i];
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObject:model.name];
        [arr addObject:model.sex_resume.intValue == 0?@"女":@"男"];
        [arr addObject:model.school];
        [arr addObject:model.tel];
        for (int j=0; j<arr.count; j++) {
            const char *name_c = [arr[j] cStringUsingEncoding:NSUTF8StringEncoding];
            xlSheetWriteStr(sheet, i+2, j,name_c, 0);
        }
       
    }
    
    NSString *documentPath =
    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject];
    
    NSString *fname = [self.manageModel.name stringByAppendingString:@".xls"];
    NSString *filename = [documentPath stringByAppendingPathComponent:fname];
    NSLog(@"filepath--%@",filename);
    
    xlBookSave(book, [filename UTF8String]);
    
    xlBookRelease(book);
    
    
    docuC = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filename]];
    
    docuC.delegate = self;
    
    [docuC presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
    
    [docuC presentPreviewAnimated:YES];
    
}


@end
