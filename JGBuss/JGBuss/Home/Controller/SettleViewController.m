//
//  SettleViewController.m
//  JGBuss
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SettleViewController.h"
#import "SettleCell.h"
#import "SureSettleCell.h"
#import "BottomSettltView.h"
#import "SureSettleController.h"
#import "JGHTTPClient+ManageJob.h"
#import "PayWageModel.h"
#import "UnSettleViewController.h"
#import "AlertWageController.h"

@interface SettleViewController ()<UITableViewDataSource,UITableViewDelegate,AlertWorkCountDelegate>
{
    UILabel *tittleL ;
    UIImageView *typeView;
    UILabel *timeL ;
    UILabel *countL ;
    UILabel *moneyL ;
    UIButton *alertbtn ;
    UITextField *alertTextView;
    int pageCount;
    UILabel *selectCountL;
    UILabel *sumMoneyL;
    int sumMoney;
    int selectCount;
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *modelArr;
@property (nonatomic,strong) NSMutableArray *cellSlectArr;
@property (nonatomic,strong) NSMutableArray *jsonArr;
@property (nonatomic,strong) NSMutableArray *selectArr;
@property (nonatomic,strong) UITextField *passwordTF;

@end

@implementation SettleViewController

-(NSMutableArray *)selectArr
{
    if (!_selectArr) {
        _selectArr = [NSMutableArray array];
    }
    return _selectArr;
}

-(NSMutableArray *)cellSlectArr
{
    if (!_cellSlectArr) {
        _cellSlectArr = [NSMutableArray array];
    }
    return _cellSlectArr;
}

-(NSMutableArray *)jsonArr
{
    if (!_jsonArr) {
        _jsonArr = [NSMutableArray array];
    }
    return _jsonArr;
}


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
    selectCountL = bottomView.countL;
    sumMoneyL = bottomView.sumMoneyL;
    bottomView.selectAllBlock = ^(BOOL isSelected){//点击全选按钮
        if(isSelected){//全选状态
            JGLog(@"====%d",isSelected);
            sumMoney = 0;
            for (SureSettleCell *cell in self.cellSlectArr) {
                cell.selectView.image = [UIImage imageNamed:@"icon_xuanzhongda"];
                cell.isSlecting = YES;
            }
            for (PayWageModel *model in self.modelArr) {
                model.isSelecting = YES;
                [self.selectArr addObject:model];
                sumMoney += model.real_money.intValue;
            }
            selectCount = (int)self.modelArr.count;
            selectCountL.text = [NSString stringWithFormat:@"选中%d人",selectCount];
            sumMoneyL.text = [NSString stringWithFormat:@"合计:%d元",sumMoney];
            [self.tableView reloadData];
            
        }else{//取消全选
            JGLog(@"----%d",isSelected);
            [self.selectArr removeAllObjects];
            for (SureSettleCell *cell in self.cellSlectArr) {
                cell.selectView.image = [UIImage imageNamed:@"icon_weixuanzhongda"];
                cell.isSlecting = NO;
            }
            for (PayWageModel *model in self.modelArr) {
                model.isSelecting = NO;
            }
            sumMoney = 0;
            selectCount = 0;
            selectCountL.text = [NSString stringWithFormat:@"选中%d人",selectCount];
            sumMoneyL.text = [NSString stringWithFormat:@"合计:%d元",sumMoney];
            [self.tableView reloadData];
            
        }
    };
    bottomView.calculateBlock = ^{//点击计算工资按钮
        
        
        if (self.selectArr.count == 0) {
            [self showAlertViewWithText:@"请选择要结算的成员" duration:1];
            return ;
        }
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入支付密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            if ([self.passwordTF.text isEqualToString:USER.pay_password]) {
                
                
                for (PayWageModel *model in self.selectArr) {
                    if (!model.remark) {
                        model.remark = @"";
                    }
                    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                    [dict setObject:model.login_id forKey:@"login_id"];
                    [dict setObject:model.job_id forKey:@"job_id"];
                    [dict setObject:model.hould_money forKey:@"hould_money"];
                    [dict setObject:model.real_money forKey:@"real_money"];
                    [dict setObject:model.remark forKey:@"remarks"];
                    
                    [self.jsonArr addObject:dict];
                    
                }
                
                NSDictionary *dic = @{@"list_t_wages_Bean":self.jsonArr};
                
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
                NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                JGLog(@"%@",jsonStr);
                IMP_BLOCK_SELF(SettleViewController);
                [JGHTTPClient PayWageByjsonStr:jsonStr jobId:self.jobId nvJobId:self.nvJobId Success:^(id responseObject) {
                    
                    [block_self showAlertViewWithText:responseObject[@"message"] duration:1];
                    
                    if ([responseObject[@"code"] intValue] == 200) {
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            UnSettleViewController *unSettleVC = [[UnSettleViewController alloc] init];
                            unSettleVC.refreshBlock = ^(){
                                [block_self requestListBycount:@"0"];
                            };
                            unSettleVC.count = responseObject[@"sum"];
                            [block_self.navigationController pushViewController:unSettleVC animated:YES];
                            [block_self.selectArr removeAllObjects];
                            [block_self.jsonArr removeAllObjects];
                            sumMoney = 0;
                            selectCount = 0;
                            selectCountL.text = [NSString stringWithFormat:@"选中%d人",selectCount];
                            sumMoneyL.text = [NSString stringWithFormat:@"合计:%d元",sumMoney];
                        });
                    }else{
                        return ;
                    }
                    
                    
                } failure:^(NSError *error) {
                    [block_self showAlertViewWithText:NETERROETEXT duration:1];
                }];
                
            }else{
                [self showAlertViewWithText:@"密码错误" duration:1];
                return ;
            }
            
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            
            textField.textAlignment = NSTextAlignmentCenter;
            textField.secureTextEntry = YES;
            self.passwordTF = textField;
            
        }];
        
        // Add the actions.
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    };
    
    [self.view addSubview:bottomView];
    
    [self requestListBycount:@"0"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        pageCount = 0;
//        [self requestListBycount:@"0"];
        [self.tableView.mj_header endRefreshing];
    }];
    
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        pageCount += 10;
        [self requestListBycount:[NSString stringWithFormat:@"%d",pageCount]];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    
}

-(void)requestListBycount:(NSString *)count
{
    JGSVPROGRESSLOAD(@"加载中...")
    [JGHTTPClient getToPayWageListByjobId:self.jobId nvJobId:self.nvJobId count:count Success:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (count.intValue) {//下拉
            
            if ([[PayWageModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_user_info"]] count] == 0) {
                [self showAlertViewWithText:@"没有更多数据" duration:1];
                return ;
            }
            
            NSMutableArray *indexPaths = [NSMutableArray array];
            for (PayWageModel *model in [PayWageModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_user_info"]]) {
                model.real_money = [[moneyL.text componentsSeparatedByString:@"元"] firstObject];
                model.hould_money = [[moneyL.text componentsSeparatedByString:@"元"] firstObject];
                [self.modelArr addObject:model];
                NSIndexPath* indexPath = [NSIndexPath indexPathForRow:self.modelArr.count-1 inSection:0];
                [indexPaths addObject:indexPath];
            }
            
            [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            return;
            
        }else{
            self.modelArr = [PayWageModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_user_info"]];
            for (PayWageModel *model in self.modelArr) {
                model.real_money = [[moneyL.text componentsSeparatedByString:@"元"] firstObject];
                model.hould_money = [[moneyL.text componentsSeparatedByString:@"元"] firstObject];
            }

        }
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        if ([[PayWageModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"list_t_user_info"]] count] == 0) {
            [self showAlertViewWithText:@"没有更多数据" duration:1];
            return ;
        }
    } failure:^(NSError *error) {
        [self showAlertViewWithText:NETERROETEXT duration:1];
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SureSettleCell";
    SureSettleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SureSettleCell" owner:nil options:nil]lastObject];
    }
    cell.delegate = self;
    cell.model = self.modelArr[indexPath.row];
    [self.cellSlectArr addObject:cell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayWageModel *model = self.modelArr[indexPath.row];
    model.isSelecting = !model.isSelecting;
    SureSettleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (model.isSelecting) {//选中一个cell
        cell.selectView.image = [UIImage imageNamed:@"icon_xuanzhongda"];
        [self.selectArr addObject:model];
        sumMoney += model.real_money.intValue;
        selectCount += 1;
    } else {//取消一个cell
        cell.selectView.image = [UIImage imageNamed:@"icon_weixuanzhongda"];
        [self.selectArr removeObject:model];
        sumMoney -= model.real_money.intValue;
        selectCount -= 1;
    }
    selectCountL.text = [NSString stringWithFormat:@"选中%d人",selectCount];
    sumMoneyL.text = [NSString stringWithFormat:@"合计:%d元",sumMoney];
    
}

/**
 *  点击修改总钱数按钮
 */
-(void)alertAllMoney:(UIButton *)btn
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入工资数额" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray *array = [moneyL.text componentsSeparatedByString:@"元"];
        if (alertTextView.text.length&&alertTextView.text.intValue!=0) {
            moneyL.text = [NSString stringWithFormat:@"%@元%@",alertTextView.text,[array lastObject]];
            for (PayWageModel *model in self.modelArr) {
                model.real_money = alertTextView.text;
                model.hould_money = alertTextView.text;
            }
            [self.tableView reloadData];
        }
        

    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        alertTextView = textField;
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
/**
 *  点击cell上的修改按钮
 */
-(void)clickAlertBtn:(UIButton *)sender
{
    SureSettleCell *cell = (SureSettleCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    PayWageModel *model = self.modelArr[indexPath.row];
    
    AlertWageController *alertVC = [[AlertWageController alloc] init];
    alertVC.model = model;
    alertVC.alertBlock = ^(NSString *realMoney,NSString *remark){
        if (realMoney&&realMoney.intValue != 0) {
            model.real_money = realMoney;
        }
        if (remark.length) {
            model.remark = remark;
        }
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:alertVC animated:YES];
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
    moneyL.text = self.money;
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
@end
