//
//  HistoryModel.h
//  JGBuss
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryModel : NSObject

/** 电话号码 */
@property (nonatomic,strong) NSString *info_tel;

/** 模板名字 */
@property (nonatomic, copy) NSString*  model_name;

/** 状态（0=已下架，1=招聘中，2=已招满） */
@property (nonatomic, copy) NSString*  status;

/** 城市ID */
@property (nonatomic, copy) NSString*  city_id;

/** 城市名字 */
@property (nonatomic, copy) NSString*  city_id_name;

/** 钱 */
@property (nonatomic, copy) NSString*  money;

/** 兼职种类 */
@property (nonatomic, copy) NSString*  type_id;

/** 兼职名字 */
@property (nonatomic, copy) NSString*  type_id_name;

/** 已有人数 */
@property (nonatomic, copy) NSString*  count;

/** 结束时间 */
@property (nonatomic, copy) NSString*  stop_date;

/** 商家Id */
@property (nonatomic, copy) NSString*  merchant_id;

/** 商家名字 */
@property (nonatomic, copy) NSString*  merchant_id_name;

/** 分类（0=热门兼职，1=精品兼职，2=普通兼职） */
@property (nonatomic, copy) NSString*  hot;

/** 待定 */
@property (nonatomic, copy) NSString*  day;

/** 兼职名称 */
@property (nonatomic, copy) NSString* name;

/** 兼职头像 */
@property (nonatomic, copy) NSString* name_image;

/** 总人数 */
@property (nonatomic, copy) NSString*  sum;

/** 工资的计算方式(元/天) */
@property (nonatomic, copy) NSString*  term;

/** 注册时间 */
@property (nonatomic, copy) NSString* regedit_time;

/** 兼职ID */
@property (nonatomic, copy) NSString*  id;

/** 服务器区分是否是同一条数据的标识 */
@property (nonatomic, copy) NSString*  alike;

/** 开始时间 */
@property (nonatomic, copy) NSString*  start_date;

/** 性别限制 */
@property (nonatomic, copy) NSString*  limit_sex;

/** 地区ID */
@property (nonatomic, copy) NSString*  area_id;

/** 地区ID */
@property (nonatomic, copy) NSString*  area_id_name;

/**  结算方式（1=月结，2=周结，3=日结，4=旅行） */
@property (nonatomic, copy) NSString*  mode;

/** 详细地址 */
@property (nonatomic, copy) NSString* address;

/** 集合地点 */
@property (nonatomic, copy) NSString* info_set_place;
/** 集合时间 */
@property (nonatomic, copy) NSString* info_set_time;
/** 工作开始时间 */
@property (nonatomic, copy) NSString* info_start_time;
/** 工作结束时间 */
@property (nonatomic, copy) NSString* info_stop_time;
/** 工作内容 */
@property (nonatomic, copy) NSString* info_work_content;
/** 工作要求 */
@property (nonatomic, copy) NSString* info_work_require;

/** 女生部分的兼职id */
@property (nonatomic,copy) NSString *nv_job_id;
/** 女生部分的总人数 */
@property (nonatomic,copy) NSString *nv_sum;
/** 女生部分已招人数 */
@property (nonatomic,copy) NSString *nv_count;

@end
