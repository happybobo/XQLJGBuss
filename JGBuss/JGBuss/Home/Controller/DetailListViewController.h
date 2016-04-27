//
//  DetailListViewController.h
//  JGBuss
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NavigatinViewController.h"
#import "ManagedModel.h"
#import "DetailModel.h"

@interface DetailListViewController : NavigatinViewController
@property (nonatomic,copy) NSString *jobId;
@property (nonatomic,strong) DetailModel *detailModel;
@property (nonatomic,strong) ManagedModel *manageModel;

@end
