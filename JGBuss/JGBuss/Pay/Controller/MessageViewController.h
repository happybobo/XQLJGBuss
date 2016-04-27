//
//  PayViewController.h
//  JGBuss
//
//  Created by apple on 16/3/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "NavigatinViewController.h"
#import <AVOSCloudIM.h>

@interface MessageViewController : NavigatinViewController

@property (nonatomic,strong) AVIMConversation *conversation;

@property (nonatomic,copy) void(^sendMessageBlock)(NSString *);
@end
