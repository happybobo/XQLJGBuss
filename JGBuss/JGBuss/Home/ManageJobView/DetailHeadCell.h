//
//  DetailHeadCell.h
//  JGBuss
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagedModel.h"
#import "DetailModel.h"

@protocol ClickManCountDelegate <NSObject>

-(void)clickBoyBtn;
-(void)clickGirlBtn;
-(void)clickOneBtn;

@end
@interface DetailHeadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *moneyL;
@property (nonatomic,strong) DetailModel *detailModel;
@property (nonatomic,strong) ManagedModel *manageModel;
@property (weak, nonatomic) IBOutlet UIView *seporLineView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *creatorL;
@property (weak, nonatomic) IBOutlet UIImageView *typeImgV;
@property (weak, nonatomic) IBOutlet UILabel *countL;
@property (weak, nonatomic) IBOutlet UILabel *scanCountL;
@property (weak, nonatomic) IBOutlet UILabel *workDateL;
@property (weak, nonatomic) IBOutlet UILabel *tittleL;
@property (weak, nonatomic) IBOutlet UIButton *boyBtn;
@property (weak, nonatomic) IBOutlet UIButton *girlBtn;
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;

@property (nonatomic,weak) id <ClickManCountDelegate>delegate;





@end
