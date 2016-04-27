//
//  DetailListCell.h
//  JGBuss
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignModel.h"

@protocol ClickCancelBtnDeleagte <NSObject>

-(void)clickLeftBtn:(UIButton *)btn;
-(void)clickRightBtn:(UIButton *)btn;

@end

@interface DetailListCell : UITableViewCell

@property (nonatomic,strong) SignModel *model;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIImageView *genderView;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *schoolL;
@property (weak, nonatomic) IBOutlet UILabel *gradeL;
@property (weak, nonatomic) IBOutlet UILabel *creditL;
@property (weak, nonatomic) IBOutlet UILabel *remindL;
@property (weak, nonatomic) IBOutlet UILabel *countL;
@property (weak, nonatomic) IBOutlet UILabel *remarkL;
@property (weak, nonatomic) IBOutlet UIButton *cancelAdmitBtn;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@property (nonatomic,weak) id<ClickCancelBtnDeleagte> delegate;

-(void)updateAConstraint;

@end
