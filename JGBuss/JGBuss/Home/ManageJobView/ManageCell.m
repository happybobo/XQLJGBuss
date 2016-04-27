//
//  ManageCell.m
//  JGBuss
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ManageCell.h"
#import "DateOrTimeTool.h"
#import "NameIdManger.h"
#import "UIButton+Background.h"

@implementation ManageCell

- (void)awakeFromNib {
    self.stateBtn.layer.masksToBounds = YES;
    self.stateBtn.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setModel:(ManagedModel *)model
{
    _model = model;
    int status = model.status.intValue;
    
    self.tittleL.text = model.name;
    self.creatorL.text = [@"负责人:" stringByAppendingString:USER.name];
    
    NSTimeInterval timeStart = model.start_date.longLongValue;
    NSRange range = NSMakeRange(5, 5);
    NSString *startDateStr = [[DateOrTimeTool getDateStringBytimeStamp:timeStart] substringWithRange:range];
    
    NSTimeInterval timeEnd = model.stop_date.longLongValue;
    NSString *endDateStr = [[DateOrTimeTool getDateStringBytimeStamp:timeEnd] substringWithRange:range];
    self.workDateL.text = [[startDateStr stringByAppendingString:@"-"] stringByAppendingString:endDateStr];
    self.countL.text = [NSString stringWithFormat:@"%@/%@",model.count,model.sum];
    self.moneyL.text = [model.money stringByAppendingString:[NameIdManger getTermNameById:model.term]];
    self.scanCountL.text = model.look;
    self.remindMsgL.text = model.remarks;
    self.typeImgV.image = [UIImage imageNamed:[self gettypeImage:model.hot]];
    
    self.stateBtn.userInteractionEnabled = NO;
    switch (status) {
        case 0:{
            
            [self.stateBtn setGrayBGAndWhiteTittle:@"录取中"];
            
            break;
        } case 1:{
            
            [self.stateBtn setGrayBGAndWhiteTittle:@"已招满"];
            
            break;
        } case 2:{
            
            [self.stateBtn setGrayBGAndWhiteTittle:@"工作中"];
            
            break;
        } case 3:{
            
            [self.stateBtn setYellowBGAndWhiteTittle:@"去结算"];
            
            break;
        } case 4:{
            
            [self.stateBtn setYellowBGAndWhiteTittle:@"去评价"];
            
            break;
        } case 5:{
            
            [self.stateBtn setGrayBGAndWhiteTittle:@"已完成"];
            
            break;
        } case 6:{
            
            [self.stateBtn setGrayBGAndWhiteTittle:@"已下架"];
            
            break;
        }
    }

}

-(NSString *)gettypeImage:(NSString*)hot
{
    switch (hot.intValue) {
        case 0:{
            
            return @"meiyou";
            
            break;
        } case 1:{
            
            return @"22";
            
            break;
        } case 2:{
            
            return @"33";
            
            break;
        } case 3:{
            
            return @"77";
            
            break;
        }
        default:
            return @"meiyou";
            break;
    }


}

@end
