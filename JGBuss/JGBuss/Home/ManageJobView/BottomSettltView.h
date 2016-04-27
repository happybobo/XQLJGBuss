//
//  BottomSettltView.h
//  JGBuss
//
//  Created by apple on 16/4/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomSettltView : UIView

+(instancetype)aBottomView;

@property (nonatomic,copy) void(^selectAllBlock)(BOOL isSelected);
@property (nonatomic,copy) void(^calculateBlock)();
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *countL;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *calculateBtn;
@property (weak, nonatomic) IBOutlet UILabel *sumMoneyL;




@end
