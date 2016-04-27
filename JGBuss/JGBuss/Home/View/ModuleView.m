//
//  ModuleView.m
//  JGBuss
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ModuleView.h"
#define WIDTH 60*SCREEN_W/375

@interface ModuleView ()


@end

@implementation ModuleView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubviews];
    }
    return self;
}

-(void)setSubviews
{
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.backgroundColor = RGBCOLOR(248, 98, 104);
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.userInteractionEnabled = YES;
    iconView.image = [UIImage imageNamed:@"icon_fabu"];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *label = [[UILabel alloc] init];
    label.font = FONT(16);
    label.text = @"发布兼职";
    label.textColor = WHITECOLOR;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    self.btn = btn;

}

-(void)layoutSubviews
{
    self.iconView.frame = CGRectMake(self.width/2-WIDTH/2, 20*Scale, WIDTH, WIDTH);
    self.label.frame = CGRectMake(0, self.height-30, self.width, 20);
    self.btn.frame = self.bounds;
}

-(void)setBgColor:(UIColor *)bgColor
{
    self.backgroundColor = bgColor;
}

-(void)setIconName:(NSString *)iconName
{
    self.iconView.image = [UIImage imageNamed:iconName];
}

@end
