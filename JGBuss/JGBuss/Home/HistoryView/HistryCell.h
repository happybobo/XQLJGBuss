//
//  HistryCell.h
//  JGBuss
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryModel.h"

@protocol ModelCellDelegate <NSObject>

-(void)useTheModel:(UIButton *)btn;
-(void)deleteTheModel:(UIButton *)btn;


@end

@interface HistryCell : UITableViewCell
@property (nonatomic,strong) HistoryModel *historyModel;
@property (weak, nonatomic) IBOutlet UILabel *creatorNameL;
@property (weak, nonatomic) IBOutlet UILabel *alertTimeL;
@property (weak, nonatomic) IBOutlet UIButton *useBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *tittleL;
@property (weak, nonatomic) IBOutlet UIImageView *rightView;
@property (nonatomic,weak) id <ModelCellDelegate> delegate;

@end
