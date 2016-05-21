//
//  JobAddresCell.m
//  JGBuss
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "JobAddresCell.h"
#import "PickerView.h"
#import "CityModel.h"
#import "UIView+AlertView.h"
#import "QLAlertView.h"
@interface JobAddresCell ()
{
    BOOL isFirstSelectCity;
}

@end
@implementation JobAddresCell

- (void)awakeFromNib {
    
    [NotificationCenter addObserver:self selector:@selector(receiveNoti:) name:kNotificationSelectCity object:nil];
    
}

-(void)receiveNoti:(NSNotification *)noti
{
    NSNumber *num = noti.object;
//    if (num.intValue-1 != self.indexCity&&isFirstSelectCity) {
//        [self showAlertViewWithText:@"请重新选择工作地点" duration:1.5];
//        [QLAlertView showAlertTittle:@"修改城市后要重新选择对应的工作地区!" message:nil];
//    }
//    isFirstSelectCity = YES;
    self.indexCity = [num intValue]-1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectAddress:(UIButton *)sender {
    [APPLICATION.keyWindow endEditing:YES];
    PickerView *pickerView = [PickerView aPickerView:^(NSString *city,NSString *Id) {
        self.selectAddTF.text = city;
        self.selectBtn.tag = Id.intValue;
    }];
    pickerView.dataType = TypeOfArea;
    CityModel *cityModel = self.cityModels[self.indexCity];
    pickerView.arrayData = cityModel.list_t_area;
    [pickerView show];
    
}

@end
