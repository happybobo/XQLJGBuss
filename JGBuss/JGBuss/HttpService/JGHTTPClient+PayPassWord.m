//
//  JGHTTPClient+PayPassWord.m
//  JGBuss
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "JGHTTPClient+PayPassWord.h"

@implementation JGHTTPClient (PayPassWord)

/**
 *  修改支付密码
 */
+(void)alertPayPassWordByNewPassWord:(NSString *)passWord
                                  Id:(NSString *)Id
                             Success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[self getToken] forKey:@"only"];
    
    [params setObject:passWord forKey:@"pay_password"];
    
    [params setObject:Id forKey:@"id"];
    
    
    NSString *Url = [APIURLCOMMON stringByAppendingString:@"T_mechant_pay_Update_Servlet"];
    
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

@end
