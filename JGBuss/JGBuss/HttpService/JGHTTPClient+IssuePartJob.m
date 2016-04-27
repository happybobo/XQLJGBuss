//
//  JGHTTPClient+IssuePartJob.m
//  JGBuss
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "JGHTTPClient+IssuePartJob.h"

@implementation JGHTTPClient (IssuePartJob)

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
    [params setObject:jobModel forKey:@"job_model"];
    
//    [params setObject:@"0" forKey:@"other"];
    [params setObject:@"0" forKey:@"lon"];
    [params setObject:@"0" forKey:@"lat"];
    
    
    NSString *Url = [APIURLCOMMON stringByAppendingString:@"T_Job_Insert_Servlet"];
    
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
 *  地区类型信息
 */
+(void)getAreaInfoByloginId:(NSString *)loginId
                    Success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[self getToken] forKey:@"only"];
    
    [params setObject:loginId forKey:@"login_id"];
    
    NSString *Url = [APIURLCOMMON stringByAppendingString:@"T_Job_Area_City_List_Servlet"];
    
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
 *  获取历史记录或者模板列表
 */
+(void)getHistoryOrModelJobListBymercntId:(NSString *)mercntId
                                     type:(NSString *)type
                                    count:(NSString *)count
                                  Success:(void (^)(id responseObject))success
                                  failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[self getToken] forKey:@"only"];
    
    [params setObject:mercntId forKey:@"merchant_id"];
    
    [params setObject:type forKey:@"type"];
    
    [params setObject:count forKey:@"count"];
    
    NSString *Url = [APIURLCOMMON stringByAppendingString:@"T_job_Model_List_Servlet"];
    
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
 *  删除兼职模板
 */
+(void)deleteTheModelByjobId:(NSString *)jobId
                    mercntId:(NSString *)mercntId
                     Success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[self getToken] forKey:@"only"];
    
    [params setObject:mercntId forKey:@"merchant_id"];
    
    [params setObject:jobId forKey:@"job_id"];
    
    NSString *Url = [APIURLCOMMON stringByAppendingString:@"T_job_Model_Delete_Servlet"];
    
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
