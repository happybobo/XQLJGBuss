//
//  SettleViewController.h
//  JGBuss
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NavigatinViewController.h"
#import "ManagedModel.h"

@interface SettleViewController : NavigatinViewController

@property (nonatomic,strong) ManagedModel *model;
@property (nonatomic,copy) NSString *nvJobId;
@property (nonatomic,copy) NSString *jobId;

@property (nonatomic,copy) NSString *money;
@end
