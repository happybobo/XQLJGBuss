//
//  PickerCell.m
//  JGBuss
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PickerCell.h"
#import "PickerView.h"

@implementation PickerCell

- (void)awakeFromNib {
    self.selectBtn.tag = 2;
    self.peopeleL.hidden = YES;
    self.selectTF.userInteractionEnabled = NO;
    self.selectBtn.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (IBAction)selectMoneyType:(UIButton *)sender {
    
    if (self.selectBtn.hidden == NO) {
        
        PickerView *pickerView = [PickerView aPickerView:^(NSString *str,NSString *Id) {
            self.selectBtn.titleLabel.text = str;
            self.selectBtn.tag = [Id intValue];
        }];
        pickerView.dataType = TypeOfTerm;
        pickerView.arrayData = @[@{@"type":@"元/月",@"id":@"0"},@{@"type":@"元/周",@"id":@"1"},@{@"type":@"元/天",@"id":@"2"},@{@"type":@"元/小时",@"id":@"3"},@{@"type":@"元/次",@"id":@"4"},@{@"type":@"义工",@"id":@"5"},@{@"type":@"面议",@"id":@"6"}];
        [pickerView show];
    }
}

@end
