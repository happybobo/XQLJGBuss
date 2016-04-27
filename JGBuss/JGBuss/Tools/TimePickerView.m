//
//  TimePickerView.m
//  driverapp_iOS
//
//  Created by 江海天 on 15/7/13.
//  Copyright (c) 2015年 dasmaster. All rights reserved.
//

#import "TimePickerView.h"
#import "NSDate+Addition.h"

@interface TimePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *_arrayLeft;
    NSArray *_arrayCenter;
    NSArray *_arrayRight;
    
    NSDateComponents *_comps;
    NSCalendar *_calendar;
    NSInteger _unitFlags;
    
    void (^_block)(NSDate *date);
}
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@end

@implementation TimePickerView
{
    __weak IBOutlet UIDatePicker *_pickerView;
}

+(TimePickerView *)aTimePickerViewWithBlock:(void (^)(NSDate *))block
{
    TimePickerView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    view->_block = block;
    return view;
}

- (void)show
{
    self.backgroundColor = RGBACOLOR(0, 0, 0, 0);
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.whiteView.transform = CGAffineTransformMakeTranslation(0, self.whiteView.height);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
        self.whiteView.transform = CGAffineTransformIdentity;
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = RGBACOLOR(0, 0, 0, 0);
        self.whiteView.transform = CGAffineTransformMakeTranslation(0, self.whiteView.height);
    } completion:^(BOOL finished) {
        _block = nil;
        [self removeFromSuperview];
    }];
}

- (void)awakeFromNib
{
    _pickerView.datePickerMode = UIDatePickerModeDate;
    _pickerView.minimumDate = [NSDate date];
    _pickerView.maximumDate = [NSDate stringToDate:@"2017-12-31" format:@"yyyy-MM-dd"];
    self.backgroundColor = [UIColor clearColor];
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.transform = CGAffineTransformMakeTranslation(0, [UIApplication sharedApplication].keyWindow.height);
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self cancle:nil];
}


- (IBAction)commit:(id)sender {
    if (_block) {
        _block(_pickerView.date);
    }
    [self dismiss];
}
- (IBAction)cancle:(id)sender {
    
    [self dismiss];
}
@end
