//
//  DatePickerView.m
//  JGBuss
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DatePickerView.h"

@interface DatePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *_arrayLeft;
    NSArray *_arrayCenter;
    NSArray *_arrayRight;
    
    NSDateComponents *_comps;
    NSCalendar *_calendar;
    NSInteger _unitFlags;
    
    void (^_block)(NSString *timeString);
}

@end

@implementation DatePickerView

+(DatePickerView *)aDatePickerViewWithBlock:(void (^)(NSString *))block
{
    DatePickerView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
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
    [_pickerView selectRow:7 inComponent:0 animated:YES];
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
    self.backgroundColor = [UIColor clearColor];
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.transform = CGAffineTransformMakeTranslation(0, [UIApplication sharedApplication].keyWindow.height);
    
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _arrayLeft = [[NSMutableArray alloc] initWithCapacity:30];
    _arrayCenter = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23"];
    _arrayRight = @[@"00",@"15",@"30",@"45"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self cancle:nil];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 50;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return _arrayCenter.count;
    }else if (component == 2){
        return _arrayRight.count;
    }
    else{
        return 1;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return _arrayCenter[row];
        
    }else if (component == 1){
        return @"时";
    }else if (component == 3){
        return @"分";
    }else {
        return _arrayRight[row];
    }
}

- (IBAction)commit:(id)sender {
    if (_block) {
        _block([NSString stringWithFormat:@"%@:%@", [self pickerView:_pickerView titleForRow:[_pickerView selectedRowInComponent:0] forComponent:0], [self pickerView:_pickerView titleForRow:[_pickerView selectedRowInComponent:2] forComponent:2]]);
    }
    [self dismiss];
}
- (IBAction)cancle:(id)sender {
    
    [self dismiss];
}



@end
