//
//  DetailHeaderCell.m
//  JianGuo
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import "DetailHeaderCell.h"
#import "DateOrTimeTool.h"
#import "NameIdManger.h"
#import "UIImageView+WebCache.h"

@implementation DetailHeaderCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(JianzhiModel *)model
{
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.name_image] placeholderImage:[UIImage imageNamed:@"icon_touxiang"]];
    self.partTittleL.text = model.name;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"%@ %@",model.money,[NameIdManger getTermNameById:model.term]];
    self.peopleCountL.text = [NSString stringWithFormat:@"%@/%@",model.count,model.sum];
    self.issueTimeL.text = [self getAtimeString:model.start_date];
#warning 不确定用哪个值
}

-(NSString *)getAtimeString:(NSString *)timeStamp
{
    return [[DateOrTimeTool compareDate:timeStamp] stringByAppendingString:@"发布"];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
