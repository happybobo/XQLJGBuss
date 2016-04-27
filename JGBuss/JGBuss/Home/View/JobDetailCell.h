//
//  JobDetailCell.h
//  JGBuss
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *jobContentTV;
@property (weak, nonatomic) IBOutlet UITextView *jobRequireTV;

@end
