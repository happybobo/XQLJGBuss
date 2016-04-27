//
//  JGUser.h
//  JianGuo
//
//  Created by apple on 16/3/5.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGUser : NSObject<NSCoding>

//登录类型
typedef NS_ENUM(NSUInteger,LoginType)
{
    LoginTypeByPhone = 3,
    LoginTypeByWeChat = 1,
    LoginTypeByQQ = 2
};

//单例模式
+(instancetype)shareUser;


/** 支付密码 */
@property (nonatomic, copy) NSString* pay_password;

/** 密码 */
@property (nonatomic, copy) NSString* password;

/** 商家Id */
@property (nonatomic, copy) NSString*  Id;

/** 微信或者QQ token */
@property (nonatomic, copy) NSString* qqwx_token;

/** 商家状态值（0=被封号，1=可以登录，但没有实名认证，2=已实名认证，3=实名审核中） */
@property (nonatomic, copy) NSString*  status;

/** 七牛 */
@property (nonatomic, copy) NSString* qiniu;

/** 电话号码 */
@property (nonatomic, copy) NSString*  tel;

/** 商家标签 */
@property (nonatomic, copy) NSString* label;

/** 商家注册时间 */
@property (nonatomic, copy) NSString* regedit_time;

/** 商家粉丝数 */
@property (nonatomic, copy) NSString*  fans_count;

/** 商家介绍 */
@property (nonatomic, copy) NSString* about;

/** 用户数 */
@property (nonatomic, copy) NSString *  user_count;

/** 商家头像 */
@property (nonatomic, copy) NSString* name_image;

/** 登录Id */
@property (nonatomic, copy) NSString *  login_id;

/** 已提供多少次兼职 */
@property (nonatomic, copy) NSString * job_count;

/** 登录时间 */
@property (nonatomic, copy) NSString* login_time;

/** 评分 */
@property (nonatomic, copy) NSString *score;

/** 商家名字 */
@property (nonatomic, copy) NSString* name;

/** 在招多少岗位 */
@property (nonatomic, copy) NSString *post;

+ (instancetype)userWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

/**
 *  存储账号信息
 *
 *  @param account 需要存储的账号
 */
+(void)saveUser:(JGUser *)user WithDictionary:(NSDictionary *)dic;

+(void)savePassWord:(NSString *)passWord;

/**
 *  返回存储的账号信息
 */
+ (JGUser *)user;
/**
 *  删除本地的用户信息 以达到退出账号效果
 */
+ (void)deleteuser;

@end
