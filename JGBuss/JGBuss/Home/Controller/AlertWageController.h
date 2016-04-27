//
//  AlertWageController.h
//  JGBuss
//
//  Created by apple on 16/4/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NavigatinViewController.h"
#import "PayWageModel.h"

@interface AlertWageController : NavigatinViewController

@property (nonatomic,copy) void(^alertBlock)(NSString* realMoney,NSString* remark);
@property (nonatomic,strong) PayWageModel *model;

@end
