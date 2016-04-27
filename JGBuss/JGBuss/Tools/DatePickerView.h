//
//  DatePickerView.h
//  JGBuss
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerView : UIView


+(DatePickerView *)aDatePickerViewWithBlock:(void (^)(NSString *timeString)) block;

@property(nonatomic, assign)BOOL isArriveStore;

-(void)show;

-(void)dismiss;


@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end
