//
//  SignUpView.m
//  JianGuo
//
//  Created by apple on 16/3/19.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import "SignUpView.h"
#import "UIView+AlertView.h"
#import "DateOrTimeTool.h"


@implementation SignUpView

/**
 *  报名提示view
 */
+(instancetype)aSignUpView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"SignUpView" owner:nil options:nil]lastObject];
}
-(void)awakeFromNib
{
    self.backgroundColor = RGBACOLOR(0, 0, 0, 0);
}

-(void)show
{
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.boardView.transform = CGAffineTransformMakeTranslation(0, self.boardView.height);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3f animations:^{
        
        self.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
        self.boardView.transform = CGAffineTransformIdentity;
    }];
}

-(void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = RGBACOLOR(0, 0, 0, 0);
        self.boardView.transform = CGAffineTransformMakeTranslation(0, self.boardView.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)closeClick:(UIButton *)sender
{
    [self dismiss];
}
//确定报名
- (IBAction)sureToSignUp:(UIButton *)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = RGBACOLOR(0, 0, 0, 0);
        self.boardView.transform = CGAffineTransformMakeTranslation(0, self.boardView.height);
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [self showAlertViewWithText:@"报名成功" duration:1];
        if (self.signupBlock) {
            self.signupBlock();
        }
        
    }];
}

-(void)setJzModel:(JianzhiModel *)jzModel
{
    self.moneyL.text = [NSString stringWithFormat:@"%@/天",jzModel.money];
}

-(void)setModel:(DetailModel *)model
{
    CGRect rect = self.addressL.frame;
    
    self.addressL.text = model.address;
    
    CGSize size = [self.addressL.text boundingRectWithSize:CGSizeMake(SCREEN_W == 320?140:MAXFLOAT, 21) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT(14)} context:nil].size;
    rect.size.width = size.width;
    self.addressL.frame = rect;
    
//    CGRect locRect = self.locationView.frame;
//    locRect.origin.x = self.addressLabel.right;
//    
//    self.locationView.frame = locRect;//之前修改frame后view没效果,是因为没关掉AutoLayout
    
    //    [self.contentView layoutSubviews];
    
    self.workDateL.text = [self getWorkDateStrStartTime:model.start_date endTime:model.stop_date];
    self.workTimeL.text = [self getWorkTimeStr:model.start_time endTime:model.stop_time];
    self.togetherAddL.text = model.set_place;
    self.togetherTimeL.text = [[DateOrTimeTool getDateStringBytimeStamp:[model.set_time floatValue]] substringFromIndex:12];
    self.genderL.text = [self getLimitAboutGender:model.limit_sex];
    self.moneyTypeL.text = [self moneyType:model.term];
    self.otherL.text = model.other;

    
}
/**
 *  工资结算方式
 */
-(NSString *)moneyType:(NSString *)term
{
    NSInteger type = [term integerValue];
    switch (type) {
        case 1:
            return @"月结";
            break;
        case 2:
            return @"周结";
            break;
        case 3:
            return @"日结";
            break;
        case 4:
            return @"小时结";
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
    NSString *startDate = [DateOrTimeTool getDateStringBytimeStamp:[startTime floatValue]];
    
    NSString *endDate = [DateOrTimeTool getDateStringBytimeStamp:[endTime floatValue]];
    
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
    NSString *startDate = [DateOrTimeTool getDateStringBytimeStamp:[startTime floatValue]];
    
    NSString *endDate = [DateOrTimeTool getDateStringBytimeStamp:[endTime floatValue]];
    
    NSString *startStr = [[NSString stringWithFormat:@"%@", startDate] substringFromIndex:12];
    
    NSString *endStr = [[NSString stringWithFormat:@"%@", endDate]substringFromIndex:12];
    return [startStr stringByAppendingString:[NSString stringWithFormat:@"-%@",endStr]];
}

@end
