//
//  BusinessCell.m
//  JianGuo
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import "BusinessCell.h"
#import "UIImageView+WebCache.h"

@implementation BusinessCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(MerchantModel *)model
{
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.name_image] placeholderImage:[UIImage imageNamed:@"icon-touxiang"]];
    self.nameLb.text = model.name;
    self.beingCountL.text = [model.post stringByAppendingString:@"个岗位在招"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
