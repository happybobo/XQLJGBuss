//
//  SureSettleCell.h
//  JGBuss
//
//  Created by apple on 16/4/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayWageModel.h"
@protocol AlertWorkCountDelegate <NSObject>

-(void)clickAlertBtn:(UIButton *)sender;


@end
@interface SureSettleCell : UITableViewCell

@property (nonatomic,strong) PayWageModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *selectView;
@property (nonatomic,assign) BOOL isSlecting;;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *telL;
@property (weak, nonatomic) IBOutlet UIButton *alertBtn;
@property (weak, nonatomic) IBOutlet UILabel *moneyL;
@property (nonatomic,weak) id <AlertWorkCountDelegate> delegate;
@end
