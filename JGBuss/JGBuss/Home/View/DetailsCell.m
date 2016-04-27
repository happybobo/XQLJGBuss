//
//  DetailsCell.m
//  JianGuo
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import "DetailsCell.h"
#import "DateOrTimeTool.h"
#import "NameIdManger.h"

@implementation DetailsCell

- (void)awakeFromNib {
    
    
}

-(void)setModel:(DetailModel *)model
{
    CGRect rect = self.addressLabel.frame;
    
    self.addressLabel.text = model.address;
    
    CGSize size = [self.addressLabel.text boundingRectWithSize:CGSizeMake(SCREEN_W == 320?140:MAXFLOAT, 21) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT(14)} context:nil].size;
    rect.size.width = size.width;
    self.addressLabel.frame = rect;
    
    CGRect locRect = self.locationView.frame;
    locRect.origin.x = self.addressLabel.right;
    
    self.locationView.frame = locRect;//之前修改frame后view没效果,是因为没关掉AutoLayout
    
//    [self.contentView layoutSubviews];
    
    self.workDateLabel.text = [self getWorkDateStrStartTime:model.start_date endTime:model.stop_date];
    self.workTimeLabel.text = [self getWorkTimeStr:model.start_time endTime:model.stop_time];
    if ([model.is_collection isEqualToString:@"yulan"]) {
        self.workTimeLabel.text = [[model.start_time stringByAppendingString:@"-"] stringByAppendingString:model.stop_time];
        self.workDateLabel.text = [[model.start_date stringByAppendingString:@"-"] stringByAppendingString:model.stop_date];
    }
    self.togetherAddressL.text = model.set_place;
    self.togetherTimeL.text = model.set_time;
    self.genderLabel.text = [NameIdManger getgenderNameById: model.limit_sex];
    self.moneyTypeL.text = [self moneyType:model.term];
    
    if ([model.other isKindOfClass:[NSNull class]]) {
        self.otherLabel.text = model.other;
    }else{
        self.otherLabel.text = @"未填写";
    }

}
/**
 *  工资结算方式
 */
-(NSString *)moneyType:(NSString *)term
{
    NSInteger type = [term integerValue];
    switch (type) {
        case 0:
            return @"月结";
            break;
        case 1:
            return @"周结";
            break;
        case 2:
            return @"日结";
            break;
        case 3:
            return @"小时结";
            break;
        case 4:
            return @"次结";
            break;
            
        default:
            return nil;
    }
}
/**
 *  判断对性别的要求
 */
-(NSString *)getLimitAboutGender:(NSString *)gender
{
    if (gender.intValue == 0) {
        return @"只招女生";
    }else if (gender.intValue == 1){
        return @"只招男生";
    }else{
        return @"男女不限";
    }
}

/**
 *  工作时间计算
 */
-(NSString *)getWorkDateStrStartTime:(NSString *)startTime endTime:(NSString *)endTime
{
    NSString *startDate = [DateOrTimeTool getDateStringBytimeStamp:[startTime longLongValue]];
    
    NSString *endDate = [DateOrTimeTool getDateStringBytimeStamp:[endTime longLongValue]];
    
    NSString *startStr = [self getWantedTimeFormatter:startDate];
    
    NSString *endStr = [self getWantedTimeFormatter:endDate];
    
    return  [startStr stringByAppendingString:[NSString stringWithFormat:@"-%@",endStr]];
}
/**
 *  截取日期中想要的部分
 */
-(NSString *)getWantedTimeFormatter:(NSString*)date
{
    NSString *str = [NSString stringWithFormat:@"%@",date];
    
    NSRange range = (NSRange){5,6};
    
    NSString *dateStr = [str substringWithRange:range];
    
    return dateStr;
    
    
}

-(NSString *)getWorkTimeStr:(NSString *)startTime endTime:(NSString *)endTime
{
    NSString *startDate = [DateOrTimeTool getDateStringBytimeStamp:[startTime longLongValue]];
    
    NSString *endDate = [DateOrTimeTool getDateStringBytimeStamp:[endTime longLongValue]];
    
    NSString *startStr = [[NSString stringWithFormat:@"%@", startDate] substringFromIndex:12];
    
    NSString *endStr = [[NSString stringWithFormat:@"%@", endDate]substringFromIndex:12];
    return [startStr stringByAppendingString:[NSString stringWithFormat:@"-%@",endStr]];
}

@end
