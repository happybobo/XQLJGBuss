//
//  PayWageModel.h
//  JGBuss
//
//  Created by apple on 16/4/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayWageModel : NSObject

/** 兼职Id */
@property (nonatomic, copy) NSString*  job_id;

/** 入学时间 */
@property (nonatomic, copy) NSString* intoschool_date_resume;

/** 完成兼职次数 */
@property (nonatomic, copy) NSString*  complete_job;

/** 学校 */
@property (nonatomic, copy) NSString* school;

/** 注册时间 */
@property (nonatomic, copy) NSString* regedit_time;

/** 真实姓名 */
@property (nonatomic, copy) NSString*  realname;

/** 取消兼职次数 */
@property (nonatomic, copy) NSString*  cancel_job;

/** 用户性别 */
@property (nonatomic, copy) NSString*  sex_resume;

/** 头像 */
@property (nonatomic, copy) NSString* name_image;

/** 登录Id */
@property (nonatomic, copy) NSString*  login_id;

/** 信用分 */
@property (nonatomic, copy) NSString*  credit;

/** 报名时间 */
@property (nonatomic, copy) NSString* time_job;

/** 备注 */
@property (nonatomic, copy) NSString* remarks_job;

/** 积分 */
@property (nonatomic, copy) NSString*  integral;

/** 登录时间 */
@property (nonatomic, copy) NSString* login_time;

/** 昵称 */
@property (nonatomic, copy) NSString* nickname;

/** 兼职于用户的状态 */
@property (nonatomic, copy) NSString*  user_status;

/** 名字 */
@property (nonatomic, copy) NSString* name;
/**
 *  钱数
 */
@property (nonatomic,copy) NSString *money;
/**
 *  电话
 */
@property (nonatomic,copy) NSString *tel;
/**
 *  是否选中
 */
@property (nonatomic,assign) BOOL isSelecting;
/**
 *  结算的备注信息
 */
@property (nonatomic,copy) NSString *remark;
/**
 *  应发工资
 */
@property (nonatomic,copy) NSString *hould_money;
/**
 *  实发工资
 */
@property (nonatomic,copy) NSString *real_money;

@end
