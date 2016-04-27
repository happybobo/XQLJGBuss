//
//  BaseViewController.h
//  JianGuo
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 *  显示错误提示框
 *
 *  @param text 错误信息
 */
- (void)showErrorViewWithText:(NSString *)text;
/**
 *  显示提示信息
 *
 *  @param text 信息
 */
- (void)showAlertViewWithText:(NSString *)text duration:(NSTimeInterval)duration;
#pragma 正则匹配手机号
- (BOOL)checkTelNumber:(NSString*) phoneNum;


@end
