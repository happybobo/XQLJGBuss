//
//  JGHTTPClient+Login.m
//  JGBuss
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "JGHTTPClient+Login.h"
#import "NSString+MD5Addition.h"

@implementation JGHTTPClient (Login)
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
               failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[self getToken] forKey:@"only"];
    
    [params setObject:phoneNum forKey:@"tel"];
    if (MD5) {
        [params setObject:[[passWord stringFromMD5] uppercaseString] forKey:@"password"];
    }else{
        [params setObject:passWord  forKey:@"password"];
    }
    
    NSString *Url = [APIURLCOMMON stringByAppendingString:@"T_user_login_Login_Merchant_Servlet"];
    
    [[JGHTTPClient sharedManager] POST:Url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  手机号快速登录
 *
 *  @param phoneNum 手机号
 *  @param success  成功回调
 *  @param failure  失败回调
 */
+(void)loginByPhoneNumQuickly:(NSString *)phoneNum
                      Success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[self getToken] forKey:@"only"];
    
    [params setObject:phoneNum forKey:@"tel"];
    
    NSString *Url = [APIURLCOMMON stringByAppendingString:@"T_user_login_Check_BackTel_Servlet"];
    
    [[JGHTTPClient sharedManager] POST:Url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
