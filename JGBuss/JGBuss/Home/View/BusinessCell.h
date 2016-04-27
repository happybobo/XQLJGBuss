//
//  BusinessCell.h
//  JianGuo
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantModel.h"

@interface BusinessCell : UITableViewCell
@property (nonatomic,strong) MerchantModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *beingCountL;
@end
