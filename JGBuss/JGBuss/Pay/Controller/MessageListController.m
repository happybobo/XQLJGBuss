//
//  MessageListController.m
//  JGBuss
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MessageListController.h"
#import "MessageListCell.h"
#import "DateOrTimeTool.h"
#import "UIImageView+WebCache.h"
#import "MessageViewController.h"

@interface MessageListController ()<UITableViewDataSource,AVIMClientDelegate,UITableViewDelegate>
{
    BOOL isfirstAppear;
}

@property (nonatomic,strong) AVIMClient *client;
@property (nonatomic,strong) AVIMConversation *conversation;
@property (nonatomic,strong) NSMutableArray *iconArr;
@property (nonatomic,strong) NSMutableArray *conversationArr;
@property (nonatomic,strong) NSMutableArray *lastMessageArr;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation MessageListController


-(NSMutableArray *)iconArr
{
    if (!_iconArr) {
        _iconArr = [NSMutableArray array];
    }
    return _iconArr;
}

-(NSMutableArray *)conversationArr
{
    if (!_conversationArr) {
        _conversationArr = [NSMutableArray array];
    }
    return _conversationArr;
}

-(NSMutableArray *)lastMessageArr
{
    if (!_lastMessageArr) {
        _lastMessageArr = [NSMutableArray array];
    }
    return _lastMessageArr;
}



-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64)];
        _tableView.delegate =self;
        _tableView.rowHeight = 60;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        [NotificationCenter addObserver:self selector:@selector(receiveMessage:) name:kNotificationDidReceiveMessage object:nil];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getLastConversitions];
        
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!isfirstAppear) {
        [self getLastConversitions];
        isfirstAppear = YES;
        [self showAlertViewWithText:@"下拉可以刷新聊天列表" duration:1];
    }
}

/**
 *  收到消息的通知
 */
-(void)receiveMessage:(NSNotification *)noti
{
    if (self.tabBarController.selectedIndex!=2) {
        [self.tabBarItem setBadgeValue:@""];
    }
    AVIMTextMessage *message = noti.object;
    BOOL isNewConversation = NO;
    for (AVIMConversation *conversation in self.conversationArr) {
        if ([conversation.conversationId isEqualToString:message.conversationId]) {
            isNewConversation = YES;
        }
    }
    if (!isNewConversation) {//一个新对话的消息
        [self getLastConversitions];
    }else{
        for (int i=0;i<self.conversationArr.count;i++) {
            AVIMConversation *conversation = [self.conversationArr objectAtIndex:i];
            if ([conversation.conversationId isEqualToString:message.conversationId]) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                MessageListCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                cell.redView.hidden = NO;
            }
        }
    }
}

#pragma 查询最近对话列表
- (void)getLastConversitions{
    
    if (self.conversationArr.count) {
        [self.conversationArr removeAllObjects];
    }
    
    //用 self.client 创建一个 query 来查询最近的 对话列表
    AVIMConversationQuery *query = [[[JGIMClient shareJgIm] getAclient] conversationQuery];
    // Tom 设置查询最近 20 个活跃对话
    query.limit = 100;
    [query whereKey:kAVIMKeyMember containedIn:@[[NSString stringWithFormat:@"%@",USER.login_id]]];//查询 有自己参与的 对话 数组
    [query findConversationsWithCallback:^(NSArray *objects, NSError *error) {
        JGLog(@"查询成功！");
        [self.tableView.mj_header endRefreshing];
        if (self.lastMessageArr.count) {
            [self.lastMessageArr removeAllObjects];
        }
        [self.conversationArr addObjectsFromArray:objects];
        
        [self.tableView reloadData];

        
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.conversationArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MessageCell";
    MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageListCell" owner:nil options:nil]lastObject];
    }
    AVIMConversation *conversation = self.conversationArr[indexPath.row];
    
    [conversation queryMessagesFromServerWithLimit:1 callback:^(NSArray *objects, NSError *error) {
        if (objects.count) {
            
            AVIMTypedMessage *message = [objects firstObject];
            cell.messageContentL.text = message.text;
            
            cell.timeL.text = [DateOrTimeTool compareDate:[[NSString stringWithFormat:@"%lld",message.sendTimestamp] substringToIndex:10]];
        }else{
            cell.timeL.text = [[NSString stringWithFormat:@"%@",conversation.createAt] substringWithRange:NSMakeRange(5, 5)];
        }
    }];
    
    
    cell.nameL.text = [conversation.attributes objectForKey:@"creatname"];
    
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:conversation.attributes[@"creatimg"]] placeholderImage:[UIImage imageNamed:@"icon_touxiang"]];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tabBarItem setBadgeValue:nil];
    MessageListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    cell.redView.hidden = YES;
    messageVC.title = cell.nameL.text;
    messageVC.hidesBottomBarWhenPushed = YES;
    messageVC.conversation = self.conversationArr[indexPath.row];
    messageVC.sendMessageBlock = ^(NSString *message){
        
        cell.messageContentL.text = message;
        
    };
    [self.navigationController pushViewController:messageVC animated:YES];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
