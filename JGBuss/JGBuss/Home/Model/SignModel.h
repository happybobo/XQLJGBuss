//
//  SignModel.h
//  JGBuss
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignModel : NSObject

/** 报名用户id */
@property (nonatomic, copy) NSString*  id;

/** 学校 */
@property (nonatomic, copy) NSString* school;

/** 注册时间 */
@property (nonatomic, copy) NSString* regedit_time;

/** 名字 */
@property (nonatomic, copy) NSString*  realname;

/** 取消次数 */
@property (nonatomic, copy) NSString*  cancel_job;

/** 头像 */
@property (nonatomic, copy) NSString* name_image;

/** 登录id */
@property (nonatomic, copy) NSString*  login_id;

/** 信用(分数值) */
@property (nonatomic, copy) NSString*  credit;

/** 积分 */
@property (nonatomic, copy) NSString*  integral;

/** 登录时间 */
@property (nonatomic, copy) NSString* login_time;

/** 昵称 */
@property (nonatomic, copy) NSString* nickname;

/** 名字 */
@property (nonatomic, copy) NSString* name;

/** 完成兼职次数 */
@property (nonatomic, copy) NSString*  complete_job;

/**
 time_job;//报名时间
 status_job;//状态值
 remarks_job;//备注
 sex_resume;//用户性别
 intoschool_date_resume;//用户入学时间
 */
/** 报名时间 */
@property (nonatomic,copy) NSString *time_job;
/** 状态值 */
@property (nonatomic,copy) NSString *user_status;
/** 备注 */
@property (nonatomic,copy) NSString *remarks_job;
/** 用户入学时间 */
@property (nonatomic,copy) NSString *intoschool_date_resume;
/** 用户性别 */
@property (nonatomic,copy) NSString *sex_resume;
@end
