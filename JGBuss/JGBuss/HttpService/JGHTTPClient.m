//
//  JGHTTPClient.m
//  JianGuo
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import "JGHTTPClient.h"
#import "NSString+MD5Addition.h"

@interface JGHTTPClient()

@property (nonatomic,strong) NSDateFormatter *formatter;

@end

@implementation JGHTTPClient

-(NSDateFormatter *)formatter
{
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateFormat:@"yyyyMMddHH"];
        [_formatter setLocale:[NSLocale currentLocale]];
    }
    return _formatter;
}


+ (instancetype)sharedManager {
    static JGHTTPClient *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    });
    return manager;
}


-(instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        
//        self.requestSerializer = [AFJSONRequestSerializer serializer];//请求
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 30;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
//        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

/**
 *  获取骑牛token
 */
+(void)getQNtokenSuccess:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[self getToken] forKey:@"only"];
    
    NSString *Url = [APIURLCOMMON stringByAppendingString:@"T_QiNiu_Servlet"];
    
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
 *  生成token
 */
+(NSString *)getToken
{
//    NSDate *date = [NSDate date];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSString *currentDateStr = [[[self sharedManager] formatter] stringFromDate:[NSDate date]];
    
    
    //xse2iowiowdg3542d49z2016-03-03 09:jfiejdw4gdeqefw33ff23fi999
    NSString *tokenStr = [[@"xse2iowiowdg3542d49z" stringByAppendingString:currentDateStr] stringByAppendingString:@"jfiejdw4gdeqefw33ff23fi999"];
    
    NSString *token = [[tokenStr stringFromMD5] uppercaseString];
    return token;
    
}
/**
 *  转成json格式字符串
 *
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
/**
 *  把小时分钟转成时间戳
 *
 *  @return 具体到分钟的开始或结束工作时间戳字符串
 */
+(NSString *)getTimeStampByDateStamp:(NSString *)dateStamp timeStr:(NSString *)timeStr
{
    long long dateInt = dateStamp.longLongValue;
    NSArray *arr = [timeStr componentsSeparatedByString:@":"];
    NSString *hour = arr[0];
    NSString *minute = arr[1];
    return [NSString stringWithFormat:@"%lld",hour.intValue*3600+minute.intValue*60+dateInt];
}

@end
