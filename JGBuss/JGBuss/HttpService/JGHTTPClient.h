//
//  JGHTTPClient.h
//  JianGuo
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface JGHTTPClient : AFHTTPSessionManager
-(NSDateFormatter *)formatter;
+ (instancetype)sharedManager;
/**
    获取 兼职信息
 */
+ (void)getInfoOfPartJob:(int)count
                  GameZoneType:(int)type
                       Success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure;

/**
 获取 滑动图片
 */
+ (void)getScrollViewImagesSuccess:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure;
/**
 *  生成token
 */
+(NSString *)getToken;
/**
 *  把字典转成json字符串
 *
 *  @param dic 要转成json的字典
 *
 *  @return json字符串 (用于自动生成 model 属性)
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
/**
 *  把小时分钟转成时间戳
 *
 *  @return 具体到分钟的开始或结束工作时间戳字符串
 */
+(NSString *)getTimeStampByDateStamp:(NSString *)dateStamp timeStr:(NSString *)timeStr;


/**
 *  获取骑牛token
 */
+(void)getQNtokenSuccess:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure;
@end
