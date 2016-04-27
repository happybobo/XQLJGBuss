//
//  PickerCell.h
//  JGBuss
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *peopeleL;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UITextField *selectTF;
@property (weak, nonatomic) IBOutlet UIImageView *rightView;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end
