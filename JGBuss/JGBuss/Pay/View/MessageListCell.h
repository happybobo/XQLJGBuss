//
//  MessageCell.h
//  JGBuss
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *redView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *messageContentL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;

@end
