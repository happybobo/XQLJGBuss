//
//  JGHTTPClient+Login.h
//  JGBuss
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "JGHTTPClient.h"

@interface JGHTTPClient (Login)
/**
 *  手机登录接口
 *
 *  @param phoneNum 手机号
 *  @param passWord 密码
 */
+(void)loginByPhoneNum:(NSString *)phoneNum
              passWord:(NSString *)passWord
                   MD5:(BOOL)MD5
               Success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure;
/**
 *  手机号快速登录
 *
 *  @param phoneNum 手机号
 *  @param success  成功回调
 *  @param failure  失败回调
 */
+(void)loginByPhoneNumQuickly:(NSString *)phoneNum
                      Success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure;
@end
