//
//  ManagedModel.h
//  JGBuss
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManagedModel : NSObject

/** 兼职状态 */
@property (nonatomic, copy) NSString*  status;

/** 城市ID */
@property (nonatomic, copy) NSString*  city_id;

/** 工资数 */
@property (nonatomic, copy) NSString*  money;

/** 兼职类别 */
@property (nonatomic, copy) NSString*  type_id;

/** 录取人数 */
@property (nonatomic, copy) NSString*  count;

/** 停止日期 */
@property (nonatomic, copy) NSString*  stop_date;

/** 商家ID */
@property (nonatomic, copy) NSString*  merchant_id;

/** 商家名称 */
@property (nonatomic, copy) NSString*  merchant_id_name;
/** 兼职级别(普通,热门等) */
@property (nonatomic, copy) NSString*  hot;

/** 待定... */
@property (nonatomic, copy) NSString*  day;

/** 兼职名称 */
@property (nonatomic, copy) NSString* name;

/** 兼职头像 */
@property (nonatomic, copy) NSString* name_image;

/** 总人数 */
@property (nonatomic, copy) NSString*  sum;

/** 工资计算方式 */
@property (nonatomic, copy) NSString*  term;

/** 注册时间 */
@property (nonatomic, copy) NSString* regedit_time;

/** 兼职ID */
@property (nonatomic, copy) NSString*  id;

/** 男女都限制的 时间戳 */
@property (nonatomic, copy) NSString*  alike;

/** 开始日期 */
@property (nonatomic, copy) NSString*  start_date;

/** 性别限制 */
@property (nonatomic, copy) NSString*  limit_sex;

/** 地区ID */
@property (nonatomic, copy) NSString*  area_id;

/** 结算方式 */
@property (nonatomic, copy) NSString*  mode;

/** 注册时间 */
@property (nonatomic, copy) NSString* reg_date;

/** 地址 */
@property (nonatomic, copy) NSString* address;

/** 浏览量 */
@property (nonatomic,copy) NSString *look;

/** 备注信息 */
@property (nonatomic,copy) NSString *remarks;

@end
