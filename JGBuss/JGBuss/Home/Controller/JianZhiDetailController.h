//
//  JianZhiDetailController.h
//  JianGuo
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import "NavigatinViewController.h"
#import "MerchantModel.h"
#import "DetailModel.h"
#import "JianzhiModel.h"

@interface JianZhiDetailController : NavigatinViewController


@property (nonatomic,strong) DetailModel *detailModel;
@property (nonatomic,strong) MerchantModel *merchantModel;
@property (nonatomic,copy) NSString *jobId;

@property (nonatomic,copy) NSString *merchantId;

@property (nonatomic,copy) NSString *loginId;

@property (nonatomic,strong) JianzhiModel *jzModel;

@end
