//
//  SureSettleController.m
//  JGBuss
//
//  Created by apple on 16/4/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SureSettleController.h"
#import "SureSettleCell.h"
#import "BottomSettltView.h"
#import "AlertWageController.h"

@interface SureSettleController ()<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *tittleL ;
    UIImageView *typeView;
    UILabel *timeL ;
    UILabel *countL ;
    UILabel *moneyL ;
    UIButton *alertbtn ;
}

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation SureSettleController

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64-49)];
        _tableView.delegate =self;
        _tableView.rowHeight = 75;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self customHeaderView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"结算";
    
    [self.view addSubview:self.tableView];
    
    BottomSettltView *bottomView = [BottomSettltView aBottomView];
    [bottomView.calculateBtn setTitle:@"确认结算" forState:UIControlStateNormal];
    bottomView.selectBtn.hidden = YES;
    bottomView.sumMoneyL.hidden = NO;
    bottomView.sumMoneyL.frame = CGRectMake(bottomView.lineView.left-100, 13, 100, 20);
    bottomView.countL.frame = CGRectMake(bottomView.sumMoneyL.left-100, 13, 100, 20);
//    bottomView.selectAllBlock = ^{//点击全选按钮
    
//    };
    [self.view addSubview:bottomView];
}

-(UIView *)customHeaderView
{
    UIView *bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 85)];
    bigView.backgroundColor = BACKCOLORGRAY;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_W, 38)];
    bgView.backgroundColor = WHITECOLOR;
    [bigView addSubview:bgView];
    
    tittleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_W-150, 20)];
    tittleL.text = @"凯宾斯基酒店宴会厅服务员";
    tittleL.font = FONT(16);
    [bgView addSubview:tittleL];
    
    typeView = [[UIImageView alloc] initWithFrame:CGRectMake(tittleL.right+10, tittleL.top, 20, 20)];
    typeView.image = [UIImage imageNamed:@"33"];
    [bgView addSubview:typeView];
    
    timeL  = [[UILabel alloc] initWithFrame:CGRectMake(typeView.right+10, typeView.top, SCREEN_W-10-typeView.right-10, 20)];
    timeL.textAlignment = NSTextAlignmentRight;
    timeL.text = @"4月1日";
    [bgView addSubview:timeL];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, bgView.bottom+10, SCREEN_W, 30)];
    bottomView.backgroundColor = WHITECOLOR;
    [bigView addSubview:bottomView];
    
    countL = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, SCREEN_W-150, 20)];
    countL.text = @"总计300人";
    [bottomView addSubview:countL];
    
    moneyL = [[UILabel alloc] initWithFrame:CGRectMake(countL.right, 5, 100, 20)];
    moneyL.text = @"1500/月";
    [bottomView addSubview:moneyL];
    
    alertbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    alertbtn.frame = CGRectMake(SCREEN_W-60, 3, 50, 24);
    [alertbtn setTitle:@"修改" forState:UIControlStateNormal];
    alertbtn.titleLabel.font = FONT(15);
    alertbtn.layer.cornerRadius = 3;
    alertbtn.layer.masksToBounds = YES;
    [alertbtn setBackgroundColor:YELLOWCOLOR];
    [alertbtn addTarget:self action:@selector(alertAllMoney:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:alertbtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, bottomView.height-1, SCREEN_W, 1)];
    lineView.backgroundColor = BACKCOLORGRAY;
    [bottomView addSubview:lineView];
    
    return bigView;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SureSettleCell";
    SureSettleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SureSettleCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlertWageController *alertVC = [[AlertWageController alloc] init];
    [self.navigationController pushViewController:alertVC animated:YES];
}

/**
 *  点击修改总钱数按钮
 */
-(void)alertAllMoney:(UIButton *)btn
{
    
}

@end
