//
//  JGUser.m
//  JianGuo
//
//  Created by apple on 16/3/5.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import "JGUser.h"

#define JGUserFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"user.data"]

@implementation JGUser

//单例模式
+(instancetype)shareUser
{
    JGUser * user = [[self alloc] init];

    return user;
}

+ (instancetype)userWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+(void)saveUser:(JGUser *)user WithDictionary:(NSDictionary *)dic 
{
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    //判断文件是否存在
//    if ([fileManager fileExistsAtPath:JGUserFile]) {//存在就删掉原来的文件
//        [fileManager removeItemAtPath:JGUserFile error:nil];
//    }
    
    if (dic) {
        NSDictionary *dict_login = [dic[@"data"] objectForKey:@"t_user_login"];
        
        user.password = dict_login[@"password"];
        user.tel = dict_login[@"tel"];
        user.qqwx_token = dict_login[@"qqwx_token"];
        user.status = dict_login[@"status"];
        user.qiniu = dict_login[@"qiniu"];
        user.login_id = dict_login[@"id"];
        
        NSDictionary *dict_merchant = [dic[@"data"] objectForKey:@"t_merchant"];
        
        user.name_image = dict_merchant[@"name_image"];
        user.about = dict_merchant[@"about"];
        user.score = dict_merchant[@"score"];
        user.regedit_time = dict_merchant[@"regedit_time"];
        user.user_count = dict_merchant[@"user_count"];
        user.name = dict_merchant[@"name"];
        user.post = dict_merchant[@"post"];
        user.login_time = dict_merchant[@"login_time"];
        user.job_count = dict_merchant[@"job_count"];
        user.Id = dict_merchant[@"id"];
        user.fans_count = dict_merchant[@"fans_count"];
        user.label = dict_merchant[@"label"];
        user.pay_password = dict_merchant[@"pay_password"];
    }
    
    [NSKeyedArchiver archiveRootObject:user toFile:JGUserFile];
    
}



+(JGUser *)user
{
    JGUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:JGUserFile];
    return user;
}

+(void)savePassWord:(NSString *)passWord
{
    JGUser *user = [JGUser user];//这种写法(声明一个新指针)可以,如果直接把 [JGUser user](也就是没有 user 这个指针的方法) 修改不了密码
    user.password = passWord;
    [self saveUser:user WithDictionary:nil];
    
    
    //这种写法修改不了,因为 [JGUser user] 修改了没保存呢,你就又通过 [JGUser user] 获取一个对象,此时它没被修改,保存也还是原来的 user
//    [JGUser user].passWord = passWord;
//    [self saveUser:[JGUser user] WithDictionary:nil loginType:0];
}

/**
 *  删除本地的用户信息 以达到退出账号效果
 */
+ (void)deleteuser
{
    NSFileManager *fielManager = [[NSFileManager alloc] init];
    NSError *error;
    [fielManager removeItemAtPath:JGUserFile error:&error];
}

MJCodingImplementation

@end


