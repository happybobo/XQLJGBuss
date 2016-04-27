//
//  CityModel.m
//  JGBuss
//
//  Created by apple on 16/3/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CityModel.h"

@interface AreaModel : NSObject

/** 城区id */
@property (nonatomic, copy) NSString*  id;

/** 城市id */
@property (nonatomic, assign) NSInteger  city_id;

/** 城区的名字(海淀) */
@property (nonatomic, copy) NSString* area_name;


@end
@implementation CityModel

+ (NSDictionary *)objectClassInArray// 实现这个方法的目的：告诉MJExtension框架statuses和ads数组里面装的是什么模型
{
    return @{
             @"list_t_area" : [AreaModel class]   };
}

@end
