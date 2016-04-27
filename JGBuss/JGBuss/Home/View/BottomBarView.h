//
//  BottomBarView.h
//  JGBuss
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClickBottomBtnDelegate <NSObject>

-(void)previewAPartJobDetail;
-(void)saveForModule;
-(void)issueAPartJob;

@end

@interface BottomBarView : UIView
@property (nonatomic,weak) id <ClickBottomBtnDelegate> delegate;
/**
 *  预览按钮
 */
@property (nonatomic,strong) UIButton *previewBtn;
/**
 *  保存为模板按钮
 */
@property (nonatomic,strong) UIButton *saveTptBtn;
/**
 *  发布兼职按钮
 */
@property (nonatomic,strong) UIButton *issueJobBtn;
@property (nonatomic,strong) UIView *lineView1;
@property (nonatomic,strong) UIView *lineView2;
@end
