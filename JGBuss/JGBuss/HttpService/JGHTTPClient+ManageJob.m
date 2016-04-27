//
//  JGHTTPClient+ManageJob.m
//  JGBuss
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "JGHTTPClient+ManageJob.h"

@implementation JGHTTPClient (ManageJob)

/**
 *  获取管理的兼职列表
 */
+(void)getManagedJobsListBymercntId:(NSString *)mercntId
                              count:(NSString *)count
                             status:(NSString *)status
                            Success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[self getToken] forKey:@"only"];
    
    [params setObject:mercntId forKey:@"merchant_id"];
    
    [params setObject:status forKey:@"status"];
    
    [params setObject:count forKey:@"count"];
    
    NSString *Url = [APIURLCOMMON stringByAppendingString:@"T_job_Merchant_Id_Zhong_Servlet"];
    
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
/**
 *  查看兼职详情
 *
 */
+(void)lookPartJobsDetailsByJobid:(NSString *)jobId
                       merchantId:(NSString *)merchantId
                          loginId:(NSString *)loginId
                            alike:(NSString *)alike
                          Success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[self getToken] forKey:@"only"];
    
    [params setObject:jobId forKey:@"job_id"];
    
    [params setObject:merchantId forKey:@"merchant_id"];
    
    [params setObject:loginId forKey:@"login_id"];
    
    [params setObject:alike forKey:@"alike"];
    
    NSString *Url = [APIURLCOMMON stringByAppendingString:@"T_Job_info_Select_JobId_Servlet"];
    
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
 *  查看报名列表
 *
 */
+(void)getSigndUpListByJobid:(NSString *)jobId
                       count:(NSString *)count
                        type:(NSString *)type
                     Success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[self getToken] forKey:@"only"];
    
    [params setObject:jobId forKey:@"job_id"];
    
    [params setObject:type forKey:@"type"];
    
    [params setObject:count forKey:@"count"];
    
    NSString *Url = [APIURLCOMMON stringByAppendingString:@"T_enroll_Job_Servlet"];
    
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
  *  改变兼职与用户的关联状态
  */
+(void)changeStausByjobId:(NSString *)jobId
                  loginId:(NSString *)loginId
                    offer:(NSString *)offer
                  Success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[self getToken] forKey:@"only"];
    
    [params setObject:jobId forKey:@"job_id"];
    
    [params setObject:loginId forKey:@"login_id"];
    
    [params setObject:offer forKey:@"offer"];
    
    NSString *Url = [APIURLCOMMON stringByAppendingString:@"T_enroll_Offer_Servlet"];
    
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
 *  改变兼职状态
 */
+(void)changeJobStausByjobId:(NSString *)jobId
                       offer:(NSString *)offer
                       alike:(NSString *)alike
                     Success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[self getToken] forKey:@"only"];
    
    [params setObject:jobId forKey:@"job_id"];
    
    [params setObject:offer forKey:@"offer"];
    
    NSString *Url = [APIURLCOMMON stringByAppendingString:@"T_enroll_Agree_Servlet"];
    
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
 *  获取一条要修改的兼职信息
 */
+(void)getAjobModelByjobId:(NSString *)jobId
                   Success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[self getToken] forKey:@"only"];
    
    [params setObject:jobId forKey:@"job_id"];
    
    NSString *Url = [APIURLCOMMON stringByAppendingString:@"T_job_Id_Servlet"];
    
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
                    failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[self getToken] forKey:@"only"];
    /*
     传参：lon        经度
     传参：lat        纬度
     传参：other        其他
     */
    NSString *startT = [self getTimeStampByDateStamp:startDate timeStr:startTime];
    NSString *endT = [self getTimeStampByDateStamp:endDate timeStr:endTime];
    
    [params setObject:cityId forKey:@"city_id"];
    [params setObject:areaId forKey:@"aera_id"];
    [params setObject:typeId forKey:@"type_id"];
    [params setObject:merntId forKey:@"merchant_id"];
    [params setObject:tittle forKey:@"name"];
    
    [params setObject:iconUrl forKey:@"name_image"];
    [params setObject:startDate forKey:@"start_date"];
    [params setObject:endDate forKey:@"stop_date"];
    [params setObject:address forKey:@"address"];
    [params setObject:settleType forKey:@"mode"];
    
    [params setObject:money forKey:@"money"];
    [params setObject:term forKey:@"term"];
    [params setObject:gender forKey:@"limit_sex"];
    [params setObject:sum forKey:@"sum"];
    [params setObject:partjobType forKey:@"hot"];
    
    [params setObject:alike forKey:@"alike"];
    [params setObject:tel forKey:@"tel"];
    [params setObject:startT forKey:@"start_time"];
    [params setObject:endT forKey:@"stop_time"];
    [params setObject:togetherPlace forKey:@"set_place"];
    
    [params setObject:togetherTime forKey:@"set_time"];
    [params setObject:jobCont forKey:@"work_content"];
    [params setObject:jobReqir forKey:@"work_require"];
    [params setObject:jobId forKey:@"job_id"];
    
    //    [params setObject:@"0" forKey:@"other"];
    [params setObject:@"0" forKey:@"lon"];
    [params setObject:@"0" forKey:@"lat"];
    
    NSString *Url = [APIURLCOMMON stringByAppendingString:@"T_job_Update_Servlet"];
    
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
/**
 *  获取要发放工资的人的列表
 */
+(void)getToPayWageListByjobId:(NSString *)jobId
                       nvJobId:(NSString *)nvJobId
                         count:(NSString *)count
                       Success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[self getToken] forKey:@"only"];
    
    [params setObject:jobId forKey:@"job_id"];
    
    [params setObject:nvJobId forKey:@"nv_job_id"];
    
    [params setObject:count forKey:@"count"];
    
    NSString *Url = [APIURLCOMMON stringByAppendingString:@"T_enroll_Job_User_Servlet"];
    
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
 *  结算工资接口
 */
+(void)PayWageByjsonStr:(NSString *)jsonStr
                jobId:(NSString *)jobId
                nvJobId:(NSString *)nvJobId
                Success:(void (^)(id responseObject))success
                failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[self getToken] forKey:@"only"];
    
    [params setObject:jsonStr forKey:@"json"];
    
    [params setObject:jobId forKey:@"job_id"];
    
    [params setObject:nvJobId forKey:@"nv_job_id"];
    
    
    NSString *Url = [APIURLCOMMON stringByAppendingString:@"T_wages_Insert_Servlet"];
    
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
