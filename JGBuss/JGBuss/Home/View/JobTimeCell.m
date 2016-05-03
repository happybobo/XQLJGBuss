//
//  JobTimeCell.m
//  JGBuss
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "JobTimeCell.h"
#import "DatePickerView.h"
#import "TimePickerView.h"
@interface JobTimeCell()
@property (nonatomic,strong) NSDateFormatter *formatter;
@end
@implementation JobTimeCell

-(NSDateFormatter *)formatter
{
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
//        [_formatter setLocale:[NSLocale currentLocale]];
        _formatter.timeZone = [NSTimeZone defaultTimeZone];
        [_formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
    }
    return _formatter;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectStartTime:(UIButton *)sender {
    [APPLICATION.keyWindow endEditing:YES];
    if ([self.nameL.text isEqualToString:@"工作日期"]) {
        TimePickerView *timePicker = [TimePickerView aTimePickerViewWithBlock:^(NSDate *date) {
            NSString *timeString = [self.formatter stringFromDate:date];
            
            NSArray *arr = [timeString componentsSeparatedByString:@" "];
            NSArray *array = [arr[arr.count-1] componentsSeparatedByString:@":"];
            long long timeA = [array[0] intValue]*3600+[array[1] intValue]*60+[array[2] intValue];
            
            NSTimeInterval time = [date timeIntervalSince1970];
            NSString *timeStamp = [NSString stringWithFormat:@"%lld",(long long)(time-timeA)];
            NSDictionary *dic = @{@"type":@"0",@"timeStamp":timeStamp};
            [NotificationCenter postNotificationName:kNotificationSelectWorkDate object:dic];
            [sender setTitle:[timeString substringWithRange:NSMakeRange(3, 5)] forState:UIControlStateNormal];
        }];
        [timePicker show];
    }else{//工作时间
        DatePickerView *pickerView = [DatePickerView aDatePickerViewWithBlock:^(NSString *timeString) {
            [sender setTitle:timeString forState:UIControlStateNormal];
        }];
        [pickerView show];
    }
    
}
- (IBAction)selectEndTime:(UIButton *)sender {
    [APPLICATION.keyWindow endEditing:YES];
    if ([self.nameL.text isEqualToString:@"工作日期"]) {
        TimePickerView *timePicker = [TimePickerView aTimePickerViewWithBlock:^(NSDate *date) {
            
            NSString *timeString = [self.formatter stringFromDate:date];
            
            
            NSArray *arr = [timeString componentsSeparatedByString:@" "];
            NSArray *array = [arr[arr.count-1] componentsSeparatedByString:@":"];
            long long timeA = [array[0] intValue]*3600+[array[1] intValue]*60+[array[2] intValue];
            
            NSTimeInterval time = [date timeIntervalSince1970];
            NSString *timeStamp = [NSString stringWithFormat:@"%lld",(long long)(time-timeA)];
            NSDictionary *dic = @{@"type":@"1",@"timeStamp":timeStamp};
            [NotificationCenter postNotificationName:kNotificationSelectWorkDate object:dic];
            [sender setTitle:[timeString substringWithRange:NSMakeRange(3, 5)] forState:UIControlStateNormal];
        }];
        [timePicker show];
    }else{//工作时间
        DatePickerView *pickerView = [DatePickerView aDatePickerViewWithBlock:^(NSString *timeString) {
            [sender setTitle:timeString forState:UIControlStateNormal];
        }];
        [pickerView show];
    }
}



@end
