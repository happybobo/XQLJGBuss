//
//  JianZhiDetailController.m
//  JianGuo
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import "JianZhiDetailController.h"
#import "DetailsCell.h"
#import "DetailHeaderCell.h"
#import "WorkDetailCell.h"
#import "BusinessCell.h"
#import <Masonry.h>
#import "SignUpView.h"

@interface JianZhiDetailController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImageView *collectionView;

@end

@implementation JianZhiDetailController

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 80;
//        _tableView.backgroundColor = BACKCOLORGRAY;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"兼职详情";
    
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    [self configBottomBar];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90;
    }else if (indexPath.section == 1){
        return 238;
    }else if (indexPath.section == 2){
        return 220;
    }else if (indexPath.section == 3){
        return 85;
    }else{
        return 40;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.merchantModel&&self.detailModel){
        return 1;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        DetailHeaderCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"DetailHeaderCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.jzModel;
        return cell;

    }else if (indexPath.section == 1){
    
        DetailsCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"DetailsCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.detailModel;
        return cell;

    }else if (indexPath.section == 2){
        
        WorkDetailCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"WorkDetailCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.detailModel;
        return cell;

        
    }else if (indexPath.section == 3){
        
        BusinessCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"BusinessCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.merchantModel;
        return cell;

    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = RGBCOLOR(247, 247, 247);

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
        view.backgroundColor = RGBCOLOR(247, 247, 247);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, SCREEN_W, 20)];
        label.font = FONT(14);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = LIGHTGRAYTEXT;
        label.text = @"您已经拉到最底部了哦";
        [view addSubview:label];
        [cell.contentView addSubview:view];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/**
 *  跳到聊天页面
 */

/**
 *  收藏这条兼职
 */
-(void)collectionThePartJob:(UIButton *)btn
{
    if(self.detailModel.is_collection.intValue == 1){
        [self showAlertViewWithText:@"您已经收藏" duration:1];
        return;
    };
    
    }
/**
 *  我要报名
 */
-(void)clickTosignUp:(UIButton *)btn
{
    SignUpView *signUpView = [SignUpView aSignUpView];
    signUpView.model = self.detailModel;
    signUpView.jzModel = self.jzModel;
    signUpView.signupBlock = ^(){
        [btn setTitle:@"已报名" forState:UIControlStateNormal];
        [btn setBackgroundColor:LIGHTGRAYTEXT];
        btn.userInteractionEnabled = NO;
    };
    [signUpView show];
}

//去掉 UItableview headerview 黏性(sticky)//其实就是改变了悬停的位置而已
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = 12; //sectionHeaderHeight
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 50, 0);
        }
    }
}

/**
 *  添加底部的工具条
 */
-(void)configBottomBar
{
    UIView *barView = [[UIView alloc] init];
    barView.backgroundColor = WHITECOLOR;
    barView.layer.shadowOpacity = 0.5;
    barView.layer.shadowOffset = CGSizeMake(0, 1);
    barView.layer.shadowColor = [UIColor blackColor].CGColor;
    [self.view addSubview:barView];
    [barView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(@(50));
        make.bottom.mas_equalTo(self.view.mas_bottom);
        
    }];
    
    //在线咨询
    UIView *bgViewChat = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W*0.2, 50)];
    [barView addSubview:bgViewChat];
    
    UIImageView *chatView = [[UIImageView alloc] initWithFrame:CGRectMake(bgViewChat.center.x-15, 5, 30, 30)];
    chatView.userInteractionEnabled = YES;
    chatView.image = [UIImage imageNamed:@"icon_liaotian"];
    [bgViewChat addSubview:chatView];
    
    UILabel *labelChat = [[UILabel alloc] initWithFrame:CGRectMake(0, chatView.bottom, bgViewChat.width, 15)];
    labelChat.text = @"在线咨询";
    labelChat.textAlignment = NSTextAlignmentCenter;
    labelChat.font = FONT(12);
    [bgViewChat addSubview:labelChat];
    
    UIButton *chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chatBtn.frame = bgViewChat.bounds;
    [chatBtn addTarget:self action:@selector(goToChatVC:) forControlEvents:UIControlEventTouchUpInside];
    [bgViewChat addSubview:chatBtn];
    
    
    //收藏
    UIView *bgViewCol = [[UIView alloc] initWithFrame:CGRectMake(bgViewChat.right, 0, SCREEN_W*0.2, 50)];
    [barView addSubview:bgViewCol];
    
    UIImageView *collectionView = [[UIImageView alloc] initWithFrame:CGRectMake(bgViewChat.center.x-15, 5, 30, 30)];
    collectionView.userInteractionEnabled = YES;
    collectionView.image = [UIImage imageNamed:@"icon_shoucang"];
    [bgViewCol addSubview:collectionView];
    self.collectionView = collectionView;
    
    UILabel *labelCollectin = [[UILabel alloc] initWithFrame:CGRectMake(0, collectionView.bottom, bgViewCol.width, 15)];
    labelCollectin.text = @"收藏";
    labelCollectin.textAlignment = NSTextAlignmentCenter;
    labelCollectin.font = FONT(12);
    [bgViewCol addSubview:labelCollectin];
    
    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.frame = bgViewCol.bounds;
    [collectBtn addTarget:self action:@selector(collectionThePartJob:) forControlEvents:UIControlEventTouchUpInside];
    [bgViewCol addSubview:collectBtn];
    
    //我要报名
    UIButton *signUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signUpBtn.frame = CGRectMake(bgViewCol.right, 0, SCREEN_W*0.6, 50);
    [signUpBtn setTitle:@"我要报名" forState:UIControlStateNormal];
    [signUpBtn addTarget:self action:@selector(clickTosignUp:) forControlEvents:UIControlEventTouchUpInside];
    [signUpBtn setBackgroundColor:YELLOWCOLOR];
    [barView addSubview:signUpBtn];
}

@end
