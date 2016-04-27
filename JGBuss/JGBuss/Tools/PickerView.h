//
//  PickerView.h
//  driverapp_iOS
//
//  Created by 江海天 on 15/7/20.
//  Copyright (c) 2015年 dasmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

//数据源枚举
typedef NS_ENUM(NSUInteger,DataType)
{
    TypeOfJob = 1,/*兼职种类 **/
    TypeOfCity= 2,
    TypeOfHot= 3,
    TypeOfSettle =4,
    TypeOfTerm = 5,
    TypeOfGender = 6,
    TypeOfArea = 7
};


@interface PickerView : UIView

+(PickerView *)aPickerView:(void (^)(NSString *str,NSString *Id))block;

@property(nonatomic, assign) DataType dataType;
@property(nonatomic, strong)NSArray *arrayData;
@property(nonatomic, assign)BOOL isDatePicker;
@property(nonatomic, assign)BOOL isCityPicker;


- (void)show;
- (void)dismiss;
@end
