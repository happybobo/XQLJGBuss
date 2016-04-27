//
//  HomeViewController.h
//  JianGuo
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import "BaseViewController.h"
#import <AVOSCloudIM.h>

@interface HomeViewController : BaseViewController

@property (nonatomic,strong) AVIMClient *client;
@property (nonatomic,strong) UIView *msgRemindView;

@end
