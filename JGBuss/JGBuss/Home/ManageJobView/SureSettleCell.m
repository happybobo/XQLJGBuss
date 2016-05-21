//
//  SureSettleCell.m
//  JGBuss
//
//  Created by apple on 16/4/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SureSettleCell.h"
#import "UIImageView+WebCache.h"

@implementation SureSettleCell

- (void)awakeFromNib {
    
}

-(void)setModel:(PayWageModel *)model
{
    _model = model;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.name_image] placeholderImage:[UIImage imageNamed:@"icon_touxiang"]];

    self.nameL.text = model.name;

    if (model.tel.intValue != 0) {
        self.telL.text = model.tel;
    }
    if (model.isSelecting) {
        self.selectView.image = [UIImage imageNamed:@"icon_xuanzhongda"];
    } else {
        self.selectView.image = [UIImage imageNamed:@"icon_weixuanzhongda"];
    }
    self.moneyL.text = model.real_money;
    
}

- (IBAction)clickReduceBtn:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickAlertBtn:)]) {
        [self.delegate clickAlertBtn:sender];
    }
    
}


@end
