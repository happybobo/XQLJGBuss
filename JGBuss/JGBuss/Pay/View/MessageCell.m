//
//  MessageCell.m
//  JGBuss
//
//  Created by apple on 16/4/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MessageCell.h"
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "JGMessage.h"

@interface MessageCell()
@end
@implementation MessageCell
- (void)awakeFromNib
{
    self.textButton.titleLabel.numberOfLines = 0;
}

- (void)setMessage:(JGMessage *)message
{
    _message = message;

    [self.textButton setTitle:self.message.text forState:UIControlStateNormal];

    
    // 强制更新
    [self layoutIfNeeded];
    
    // 设置按钮的高度就是titleLabel的高度
    [self.textButton updateConstraints:^(MASConstraintMaker *make) {
        CGFloat buttonH = self.textButton.titleLabel.frame.size.height + 30;
        make.height.mas_equalTo(buttonH);
    }];
    
    // 强制更新
    [self layoutIfNeeded];
    
    // 计算当前cell的高度
//    CGFloat buttonMaxY = CGRectGetMaxY(self.textButton.frame);
//    CGFloat iconMaxY = CGRectGetMaxY(self.iconView.frame);
//    self.message.cellHeight = MAX(buttonMaxY, iconMaxY) + 10;
}
@end
