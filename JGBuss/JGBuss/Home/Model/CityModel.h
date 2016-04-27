//
//  CityModel.h
//  JGBuss
//
//  Created by apple on 16/3/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject


/** 城市id */
@property (nonatomic, copy) NSString*  id;

/** 城市名字 */
@property (nonatomic, copy) NSString* city;

/** 城区数组 */
@property (nonatomic, strong) NSArray* list_t_area;

@end
