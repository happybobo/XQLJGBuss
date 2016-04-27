//
//  BottomSettltView.m
//  JGBuss
//
//  Created by apple on 16/4/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BottomSettltView.h"
#import <Masonry.h>

@implementation BottomSettltView

-(void)awakeFromNib
{
    CGRect rect = self.frame;
    rect.size.width = SCREEN_W;
    rect.origin.y = SCREEN_H-49-64;
    self.frame = rect;
    
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    
    self.calculateBtn.frame = CGRectMake(SCREEN_W-100, 0, 100, 49);
    self.lineView.frame = CGRectMake(SCREEN_W-101, 0, 1, 49);
    self.sumMoneyL.hidden = NO;
    
}

+(instancetype)aBottomView
{
    BottomSettltView *bottomView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
    return bottomView;
}
- (IBAction)clickSelectBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if(sender.selected){
        [sender setImage:[UIImage imageNamed:@"icon_xuanzhongda"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"icon_weixuanzhongda"] forState:UIControlStateNormal];
    }
    if (self.selectAllBlock) {
        self.selectAllBlock(sender.selected);
    }
    
}
- (IBAction)clickCalculateBtn:(UIButton *)sender {
    if (self.calculateBlock) {
        self.calculateBlock();
    }
}

@end
