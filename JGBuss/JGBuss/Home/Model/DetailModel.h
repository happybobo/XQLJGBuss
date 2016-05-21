//
//  DetailModel.h
//  JianGuo
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject


/** 工资结算方式 */

@property (nonatomic,copy) NSString *mode;
/** 兼职id */
@property (nonatomic, copy) NSString*   id;

/** 其他 */
@property (nonatomic, copy) NSString* other;

/** 经度 */
@property (nonatomic, copy) NSString*   lon;

/** 工作开始日期 */
@property (nonatomic, copy) NSString*   start_date;

/** 工作要求 */
@property (nonatomic, copy) NSString* work_require;

/** 工作结束日期 */
@property (nonatomic, copy) NSString*  stop_date;

/** 工作结束时间 */
@property (nonatomic, copy) NSString*   stop_time;

/** 工作开始时间 */
@property (nonatomic, copy) NSString*   start_time;

/** 纬度 */
@property (nonatomic, copy) NSString*   lat;

/** 兼职信息表关联id */
@property (nonatomic, copy) NSString*   job_id;

/** 工作地址 */
@property (nonatomic, copy) NSString* address;

/** 集合地点 */
@property (nonatomic, copy) NSString* set_place;

/** 集合时间 */
@property (nonatomic, copy) NSString*   set_time;

/** 性别限制 */
@property (nonatomic, copy) NSString*   limit_sex;

/** 工资结算方式 */
@property (nonatomic, copy) NSString*   term;

/** 工作内容 */
@property (nonatomic, copy) NSString* work_content;

/** 是否收藏 */
@property (nonatomic, copy) NSString*   is_collection;
/*nv_job_id
nv_sum
nv_count*/
/** 女生部分的兼职id */
@property (nonatomic,copy) NSString *nv_job_id;
/** 女生部分的总人数 */
@property (nonatomic,copy) NSString *nv_sum;
/** 女生部分已招人数 */
@property (nonatomic,copy) NSString *nv_count;
/** 女生部分报名人数 */
@property (nonatomic,copy) NSString *nv_user_count;

@end
