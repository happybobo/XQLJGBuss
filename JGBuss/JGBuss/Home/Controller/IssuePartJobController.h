//
//  IssuePartJobController.h
//  JGBuss
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NavigatinViewController.h"
#import "HistoryModel.h"

@interface IssuePartJobController : NavigatinViewController

/**
 *  是不是来修改
 */
@property (nonatomic,assign) BOOL isAlert;

@property (nonatomic,copy) NSString *jobId;

@property (nonatomic,copy) void(^refreshBlock)();

@property (nonatomic,strong) HistoryModel *model;

@property (nonatomic,strong) NSMutableArray *cityModels;

@property (nonatomic,strong) NSMutableArray *jobTypes;

@end
