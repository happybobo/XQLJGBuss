//
//  JGHTTPClient+ManageJob.h
//  JGBuss
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "JGHTTPClient.h"

@interface JGHTTPClient (ManageJob)

/**
 *  获取管理的兼职列表
 */
+(void)getManagedJobsListBymercntId:(NSString *)mercntId
                              count:(NSString *)count
                             status:(NSString *)status
                            Success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;;

/**
 *  查看兼职详情
 *
 */
+(void)lookPartJobsDetailsByJobid:(NSString *)jobId
                       merchantId:(NSString *)merchantId
                          loginId:(NSString *)loginId
                            alike:(NSString *)alike
                          Success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;
/**
 *  查看报名列表
 *
 */
+(void)getSigndUpListByJobid:(NSString *)jobId
                       count:(NSString *)count
                          type:(NSString *)type
                          Success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;
/**
 *  改变兼职与用户的关联状态
 */
+(void)changeStausByjobId:(NSString *)jobId
                  loginId:(NSString *)loginId
                    offer:(NSString *)offer
                  Success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;
/**
 *  改变兼职状态
 */
+(void)changeJobStausByjobId:(NSString *)jobId
                    offer:(NSString *)offer
                    alike:(NSString *)alike
                  Success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

/**
 *  获取一条要修改的兼职信息
 */
+(void)getAjobModelByjobId:(NSString *)jobId
                     Success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;

/**
 *  修改兼职信息
 */
+(void)alertJobInfoBycityId:(NSString *)cityId
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
                   jobId:(NSString *)jobId
                    Success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;

/**
 *  获取要发放工资的人的列表
 */
+(void)getToPayWageListByjobId:(NSString *)jobId
                   nvJobId:(NSString *)nvJobId
                     count:(NSString *)count
                   Success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure;

/**
 *  结算工资接口
 */
+(void)PayWageByjsonStr:(NSString *)jsonStr
                  jobId:(NSString *)jobId
                  nvJobId:(NSString *)nvJobId
              Success:(void (^)(id responseObject))success
              failure:(void (^)(NSError *error))failure;

@end
