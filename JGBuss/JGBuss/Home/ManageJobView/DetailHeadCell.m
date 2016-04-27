//
//  DetailHeadCell.m
//  JGBuss
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DetailHeadCell.h"
#import "DateOrTimeTool.h"
#import "NameIdManger.h"

@implementation DetailHeadCell

- (void)awakeFromNib {
    self.boyBtn.hidden = YES;
    self.girlBtn.hidden = YES;
    self.oneBtn.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setManageModel:(ManagedModel *)manageModel
{
    _manageModel = manageModel;
    if ([manageModel.alike isEqualToString:@"0"]) {
        self.oneBtn.hidden = NO;
        [self.oneBtn setTitle:[NSString stringWithFormat:@"当前报名情况:%@/%@",manageModel.count,manageModel.sum] forState:UIControlStateNormal];
    }else{
        self.boyBtn.hidden = NO;
        self.girlBtn.hidden = NO;
        [self.boyBtn setTitle:[NSString stringWithFormat:@"男生部分:%@/%@",manageModel.count,manageModel.sum] forState:UIControlStateNormal];
    }
    self.tittleL.text = manageModel.name;
    self.creatorL.text = [NSString stringWithFormat:@"负责人:%@",manageModel.merchant_id_name];
    NSTimeInterval timeStart = manageModel.start_date.longLongValue;
    NSRange range = NSMakeRange(5, 5);
    NSString *startDateStr = [[DateOrTimeTool getDateStringBytimeStamp:timeStart] substringWithRange:range];
    
    NSTimeInterval timeEnd = manageModel.stop_date.longLongValue;
    NSString *endDateStr = [[DateOrTimeTool getDateStringBytimeStamp:timeEnd] substringWithRange:range];
    self.workDateL.text = [[startDateStr stringByAppendingString:@"-"] stringByAppendingString:endDateStr];
    self.countL.text = [[manageModel.count stringByAppendingString:@"/"]stringByAppendingString:manageModel.sum];
    self.moneyL.text = [manageModel.money stringByAppendingString:[NameIdManger getTermNameById:manageModel.term]];
    self.scanCountL.text = manageModel.look;
}
-(void)setDetailModel:(DetailModel *)detailModel
{
    _detailModel = detailModel;
    [self.girlBtn setTitle:[NSString stringWithFormat:@"女生部分:%@/%@",detailModel.nv_count,detailModel.nv_sum] forState:UIControlStateNormal];
}
- (IBAction)clickBoyBtn {
    
    if ([self.delegate respondsToSelector:@selector(clickBoyBtn)]) {
        [self.delegate clickBoyBtn];
    }
    
}
- (IBAction)clickGirlBtn {
    
    if ([self.delegate respondsToSelector:@selector(clickGirlBtn)]) {
        [self.delegate clickGirlBtn];
    }
}
- (IBAction)clickOneBtn {
    if ([self.delegate respondsToSelector:@selector(clickOneBtn)]) {
        [self.delegate clickOneBtn];
    }
}

@end
