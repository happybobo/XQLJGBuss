//
//  JianzhiModel.h
//  JianGuo
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JianzhiModel : NSObject

/** 兼职id */
@property (nonatomic, copy) NSString*  id;

/** 要招的总人数 */
@property (nonatomic, copy) NSString*  sum;

/** 开始时间 */
@property (nonatomic, copy) NSString*  start_date;

/** 工资钱 */
@property (nonatomic, copy) NSString*  money;

/** 注册时间 */
@property (nonatomic, copy) NSString* regedit_time;

/** 已报名人数|已录取人数 */
@property (nonatomic, copy) NSString*  count;

/** 结束时间 */
@property (nonatomic, copy) NSString*  stop_date;

/** 不知道(应该是工作几天) */
@property (nonatomic, copy) NSString*  day;

/** 头像 */
@property (nonatomic, copy) NSString* name_image;

/** 分类（0=热门兼职，1=精品兼职，2=普通兼职） */
@property (nonatomic, copy) NSString*  hot;

/** 城市id */
@property (nonatomic, copy) NSString*  city_id;

/** 工作地址 */
@property (nonatomic, copy) NSString* address;

/** 性别限制（0=只招女，1=只招男，2=不限男女） */
@property (nonatomic, copy) NSString*  limit_sex;

/** 期限（1=月结，2=周结，3=日结，4=小时结） */
@property (nonatomic, copy) NSString*  term;

/** 商家ID */
@property (nonatomic, copy) NSString*  merchant_id;

/** 状态（0=已下架，1=招聘中，2=已招满） */
@property (nonatomic, copy) NSString*  status;

/** 名称 */
@property (nonatomic, copy) NSString* name;

@end
