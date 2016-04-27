//
//  AppDelegate.m
//  JGBuss
//
//  Created by apple on 16/3/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "JGHTTPClient.h"
#import "JGHTTPClient+Login.h"
#import "UIWindow+Extension.h"
#import "LoginViewController.h"
#import <AVOSCloud/AVOSCloud.h>
//如果使用了实时通信模块，请添加下列导入语句
#import <AVOSCloudIM/AVOSCloudIM.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [AVOSCloud setApplicationId:@"AtwJtfIJPKQFtti8D3gNjMmb-gzGzoHsz"
                      clientKey:@"spNrDrtGWAXP633DkMMWT65B"];
    
    //设置导航栏
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    if (USER.login_id) {
        //自动登录
        [self autoLoginWhenRestart];
    }
    
    [JGHTTPClient getQNtokenSuccess:^(id responseObject) {
        JGLog(@"%@",responseObject);
        if ([responseObject[@"message"] isEqualToString:@"200"]) {
            [USERDEFAULTS setObject:responseObject[@"token"] forKey:@"QNtoken"];
        }
    } failure:^(NSError *error) {
        JGLog(@"%@",error);
    }];
    [self.window switchRootViewController];
    
    [self.window makeKeyAndVisible];

    return YES;
}


-(void)autoLoginWhenRestart
{
    JGUser *user = [JGUser user];
//    NSLog(@"%@  ***************  %@",user.phoneNum,user.password);
    [JGHTTPClient loginByPhoneNum:user.tel passWord:user.password MD5:NO Success:^(id responseObject) {
        JGLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue] == 200) {
            JGUser *user = [JGUser shareUser];
            [JGUser saveUser:user WithDictionary:responseObject];
        }
        
    } failure:^(NSError *error) {
        JGLog(@"%@",error)
    }];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
