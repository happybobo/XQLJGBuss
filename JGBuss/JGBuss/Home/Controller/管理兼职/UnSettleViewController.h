//
//  UnSettleViewController.h
//  JGBuss
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NavigatinViewController.h"

@interface UnSettleViewController : NavigatinViewController

@property (nonatomic,copy) NSString *count;
@property (nonatomic,copy) void(^refreshBlock)();
@end
