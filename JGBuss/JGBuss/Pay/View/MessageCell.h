//
//  MessageCell.h
//  JGBuss
//
//  Created by apple on 16/4/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JGMessage;

@interface MessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *textButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIButton *rightTextBtn;
@property (weak, nonatomic) IBOutlet UIImageView *rightIconView;
@property (nonatomic,strong) JGMessage *message;

@end
