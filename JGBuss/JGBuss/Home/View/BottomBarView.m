//
//  BottomBarView.m
//  JGBuss
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BottomBarView.h"

@implementation BottomBarView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubviews];
    }
    return self;
}

-(void)setSubviews
{
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    
    self.previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.previewBtn.showsTouchWhenHighlighted = YES;
    self.previewBtn.frame = CGRectMake(0, 0, SCREEN_W/3, 49);
    self.previewBtn.tag = 1000;
    [self.previewBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.previewBtn setTitle:@"预览兼职" forState:UIControlStateNormal];
    [self.previewBtn setTitleColor:LIGHTGRAYTEXT forState:UIControlStateNormal];
    
    self.saveTptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveTptBtn.showsTouchWhenHighlighted = YES;
    self.saveTptBtn.tag = 1001;
    self.saveTptBtn.frame = CGRectMake(SCREEN_W/3, 0, SCREEN_W/3, 49);
    [self.saveTptBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.saveTptBtn setTitle:@"保存为模板" forState:UIControlStateNormal];
    [self.saveTptBtn setTitleColor:LIGHTGRAYTEXT forState:UIControlStateNormal];
    
    self.issueJobBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.issueJobBtn.showsTouchWhenHighlighted = YES;
    self.issueJobBtn.tag = 1002;
    self.issueJobBtn.frame = CGRectMake(2*SCREEN_W/3, 0, SCREEN_W/3, 49);
    [self.issueJobBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.issueJobBtn setTitle:@"发布兼职" forState:UIControlStateNormal];
    [self.issueJobBtn setTitleColor:LIGHTGRAYTEXT forState:UIControlStateNormal];
    [self addSubview:self.previewBtn];
    [self addSubview:self.saveTptBtn];
    [self addSubview:self.issueJobBtn];
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = BACKCOLORGRAY;
    [self addSubview:self.lineView1];
    self.lineView2 = [[UIView alloc] init];
    self.lineView2.backgroundColor = BACKCOLORGRAY;
    [self addSubview:self.lineView2];
}
-(void)layoutSubviews
{
    self.lineView1.frame = CGRectMake(SCREEN_W/3-1, 0, 2, self.height);
    self.lineView2.frame = CGRectMake(2*SCREEN_W/3-1, 0, 2, self.height);
}
-(void)clickBtn:(UIButton *)btn
{
    if (btn.tag == 1000) {//预览
        if([self.delegate respondsToSelector:@selector(previewAPartJobDetail)]){
            [self.delegate previewAPartJobDetail];
        }
    }else if (btn.tag == 1001){//保存模板
        if([self.delegate respondsToSelector:@selector(saveForModule)]){
            [self.delegate saveForModule];
        }
    }else{//发布兼职
        if([self.delegate respondsToSelector:@selector(issueAPartJob)]){
            [self.delegate issueAPartJob];
        }
    }
}

@end
