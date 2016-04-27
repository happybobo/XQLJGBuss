//
//  JobDetailCell.m
//  JGBuss
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "JobDetailCell.h"
#import "UITextView+placeholder.h"

@implementation JobDetailCell

- (void)awakeFromNib {
    self.jobContentTV.placeholder = @"请填写您的工作内容";
    self.jobRequireTV.placeholder = @"请填写您的工作要求";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
