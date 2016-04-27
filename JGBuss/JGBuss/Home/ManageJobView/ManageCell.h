//
//  ManageCell.h
//  JGBuss
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagedModel.h"

@interface ManageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *moneyL;
@property (nonatomic,strong) ManagedModel *model;
@property (weak, nonatomic) IBOutlet UILabel *creatorL;
@property (weak, nonatomic) IBOutlet UIImageView *typeImgV;
@property (weak, nonatomic) IBOutlet UILabel *tittleL;
@property (weak, nonatomic) IBOutlet UILabel *workDateL;
@property (weak, nonatomic) IBOutlet UILabel *countL;
@property (weak, nonatomic) IBOutlet UILabel *remindMsgL;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *scanCountL;

@end
