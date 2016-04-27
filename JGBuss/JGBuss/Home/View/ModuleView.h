//
//  ModuleView.h
//  JGBuss
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModuleView : UIView

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,strong) UIColor *bgColor;
@property (nonatomic,copy) NSString *iconName;

@end
