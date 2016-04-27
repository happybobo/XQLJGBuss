//
//  JGHTTPClient+IssuePartJob.h
//  JGBuss
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "JGHTTPClient.h"

@interface JGHTTPClient (IssuePartJob)

/**
 *  录入兼职信息接口
 */
+(void)postPartJobInfoBycityId:(NSString *)cityId
                        areaId:(NSString *)areaId
                        typeId:(NSString *)typeId
                       merntId:(NSString *)merntId
                        tittle:(NSString *)tittle
                       iconUrl:(NSString *)iconUrl
                       startDate:(NSString *)startDate
                       endDate:(NSString *)endDate
                       address:(NSString *)address
                       settleType:(NSString *)settleType
                         money:(NSString *)money
                         term:(NSString *)term
                         gender:(NSString *)gender
                     peopleSum:(NSString *)sum
                    partjobType:(NSString *)partjobType
                      alike:(NSString *)alike
                      tel:(NSString *)tel
                      startTime:(NSString *)startTime
                      endTime:(NSString *)endTime
                      togetherPlace:(NSString *)togetherPlace
                      togetherTime:(NSString *)togetherTime
                       jobCont:(NSString *)jobCont
                       jobReqir:(NSString *)jobReqir
                      jobModel:(NSString *)jobModel

               Success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure;

/**
 *  地区类型信息
 */
+(void)getAreaInfoByloginId:(NSString *)loginId
                    Success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;
/**
 *  获取历史记录或者模板列表 类型（0=历史，1=模板）
 */
+(void)getHistoryOrModelJobListBymercntId:(NSString *)mercntId
                                     type:(NSString *)type
                                    count:(NSString *)count
                    Success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;
/**
 *  删除兼职模板
 */
+(void)deleteTheModelByjobId:(NSString *)jobId
                    mercntId:(NSString *)mercntId
                     Success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;;
@end
