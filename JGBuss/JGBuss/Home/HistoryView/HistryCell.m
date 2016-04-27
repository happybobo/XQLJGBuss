//
//  HistryCell.m
//  JGBuss
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HistryCell.h"
#import "JGHTTPClient+IssuePartJob.h"

@implementation HistryCell

- (void)awakeFromNib {

    self.useBtn.layer.borderColor = LIGHTGRAYTEXT.CGColor;
    self.useBtn.layer.borderWidth = 1;
    self.useBtn.layer.cornerRadius = 3;
    self.useBtn.layer.masksToBounds = YES;
    
    self.cancelBtn.layer.borderColor = LIGHTGRAYTEXT.CGColor;
    self.cancelBtn.layer.borderWidth = 1;
    self.cancelBtn.layer.cornerRadius = 3;
    self.cancelBtn.layer.masksToBounds = YES;
    
    self.rightView.hidden = YES;
    self.useBtn.hidden = YES;
    self.cancelBtn.hidden = YES;
}

-(void)setHistoryModel:(HistoryModel *)historyModel
{
    if ([historyModel.model_name isEqualToString:@"0"]) {
        self.tittleL.text = historyModel.name;
    }else{
        self.tittleL.text = historyModel.model_name;
    }
    NSRange range = NSMakeRange(5,5);
    self.alertTimeL.text = [historyModel.regedit_time substringWithRange:range];
    self.creatorNameL.text = USER.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (IBAction)deleteTheModel:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(deleteTheModel:)]) {
        [self.delegate deleteTheModel:sender];
    }
    
}
- (IBAction)userTheModel:(UIButton *)sender {
   
    if ([self.delegate respondsToSelector:@selector(useTheModel:)]) {
        [self.delegate useTheModel:sender];
    }
    
}

@end
