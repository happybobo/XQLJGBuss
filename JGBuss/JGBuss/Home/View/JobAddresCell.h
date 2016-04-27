//
//  JobAddresCell.h
//  JGBuss
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobAddresCell : UITableViewCell
@property (nonatomic,assign) int indexCity;
@property (nonatomic,strong) NSMutableArray *cityModels;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UITextField *selectAddTF;
@property (weak, nonatomic) IBOutlet UITextField *inPutDetAddTF;
@property (weak, nonatomic) IBOutlet UILabel *nameL;

@end
