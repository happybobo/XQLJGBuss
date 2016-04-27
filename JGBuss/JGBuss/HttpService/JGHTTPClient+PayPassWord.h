//
//  JGHTTPClient+PayPassWord.h
//  JGBuss
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "JGHTTPClient.h"

@interface JGHTTPClient (PayPassWord)
/**
 *  修改支付密码
 */
+(void)alertPayPassWordByNewPassWord:(NSString *)passWord
                             Id:(NSString *)Id
                             Success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;

@end
