//
//  DetailListCell.m
//  JGBuss
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DetailListCell.h"
#import "UIImageView+WebCache.h"
#import "DateOrTimeTool.h"
#import "UIButton+Background.h"
@interface DetailListCell()
{
    
    __weak IBOutlet NSLayoutConstraint *leftBtnToRightBtn;
    __weak IBOutlet NSLayoutConstraint *statebtntoLeft;
    __weak IBOutlet NSLayoutConstraint *statebtnWidth;
    UIButton *callTelBtn;
}

@end
@implementation DetailListCell

- (void)awakeFromNib {
    callTelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [callTelBtn setTitleColor:BLUECOLOR forState:UIControlStateNormal];
    [callTelBtn addTarget:self action:@selector(callTel) forControlEvents:UIControlEventTouchUpInside];
    callTelBtn.frame = self.remarkL.bounds;
    [self.remarkL addSubview:callTelBtn];
}

-(void)prepareForReuse
{
    leftBtnToRightBtn.constant = 5;
    statebtntoLeft.constant = 20;
    statebtnWidth.constant = 0;
    self.cancelAdmitBtn.hidden = NO;
    self.stateBtn.hidden = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
/*
 switch (self.type.intValue) {
 case 0:{
 
 [cell.cancelAdmitBtn setTitle:@"暂不录取" forState:UIControlStateNormal];
 [cell.stateBtn setTitle:@"确认录取" forState:UIControlStateNormal];
 
 break;
 } case 1:{
 
 
 //            [cell updateAConstraint];
 //            cell.stateBtn.hidden = YES;
 [cell.cancelAdmitBtn setTitle:@"取消录取" forState:UIControlStateNormal];
 [cell.stateBtn setTitle:@"待确认中" forState:UIControlStateNormal];
 break;
 } case 2:{
 
 cell.cancelAdmitBtn.hidden = YES;
 [cell.stateBtn setTitle:@"已取消" forState:UIControlStateNormal];
 
 break;
 }
 default:
 break;
 }

 */
-(void)setModel:(SignModel *)model
{
    _model = model;
    int status = model.user_status.intValue;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.name_image] placeholderImage:[UIImage imageNamed:@"icon_touxiang"]];
    
    if (model.name.length&&![model.name isEqualToString:@"null"]&&![model.name isKindOfClass:[NSNull class]]) {
        self.nameL.text = model.name;
    }
    self.genderView.image = [UIImage imageNamed:[self selectGenderImage:model.sex_resume]];
    if (model.school.length!=0) {
        self.schoolL.text = model.school;
    }
    if (model.intoschool_date_resume.length != 0) {
        self.gradeL.text = [model.intoschool_date_resume substringWithRange:NSMakeRange(0, 4)] ;
    }
    self.countL.text = [NSString stringWithFormat:@"完成%@次兼职,取消%@次兼职",model.complete_job,model.cancel_job];
    self.creditL.text = [self getCredit:model.credit];
    if (model.remarks_job.length!=0) {
        self.remarkL.text = model.remarks_job;
    }
    [callTelBtn setTitle:model.tel forState:UIControlStateNormal];
    self.timeL.text = [model.time_job substringToIndex:16];

    switch (status) {
        case 0:{
            
            [self.cancelAdmitBtn setYellowBGAndWhiteTittle:@"暂不录取"];
            [self.stateBtn setRedBGAndWhiteTittle:@"确认录取"];
            break;
        } case 1:{
            
            
            
            break;
        }
        case 7:
        case 2:{
            
            self.cancelAdmitBtn.hidden = YES;
            [self.stateBtn setGrayBGAndWhiteTittle:@"已取消"];
            
            break;
        } case 3:{
            
            [self.cancelAdmitBtn setYellowBGAndWhiteTittle:@"取消录取"];
            [self.stateBtn setGrayBGAndWhiteTittle:@"待确认"];
            
            break;
        } case 4:{
            
            self.cancelAdmitBtn.hidden = YES;
            [self.stateBtn setGrayBGAndWhiteTittle:@"用户已取消"];
            
            break;
        } case 5:{
            
            [self updateAConstraint];
            [self.cancelAdmitBtn setYellowBGAndWhiteTittle:@"取消录取"];
            
            break;
        } case 6:{
            
            self.cancelAdmitBtn.hidden = YES;
            [self.stateBtn setGrayBGAndWhiteTittle:@"用户已取消"];
            
            break;
        }case 8:{
            
            self.cancelAdmitBtn.hidden = YES;
            [self.stateBtn setGrayBGAndWhiteTittle:@"工作中"];
            
            break;
        }
        case 10:
        case 9:{
            
            self.cancelAdmitBtn.hidden = YES;
            [self.stateBtn setYellowBGAndWhiteTittle:@"去结算"];
            
            break;
        }case 11:{
            
            
            break;
        }case 12:{
            
            self.cancelAdmitBtn.hidden = YES;
            [self.stateBtn setYellowBGAndWhiteTittle:@"已完成"];
            
            break;
        }
        default:
            break;
    }

    
}

-(NSString *)getStateStr:(NSString *)status
{
    return @"啦啦啦啦";
}

-(NSString *)getCredit:(NSString *)credit
{
    if (credit.intValue >60) {
        return @"信用合格";
    }else if (credit.intValue<30){
        return @"信用低";
    }else{
        return @"哈哈哈";
    }
}

-(NSString *)selectGenderImage:(NSString *)gender
{
    if (gender.intValue == 0) {
        return @"icon_woman";
    }else if(gender.intValue == 1){
        return @"icon_man";
    }else{
        return @"meiyou";
    }
}

- (IBAction)clickLeftBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickLeftBtn:)]) {
        [self.delegate clickLeftBtn:sender];
    }
}
- (IBAction)clickRightBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickRightBtn:)]) {
        [self.delegate clickRightBtn:sender];
    }
}

-(void)updateAConstraint
{
    self.stateBtn.hidden = YES;
    leftBtnToRightBtn.constant = 0;
    statebtnWidth.constant = 0;
    statebtntoLeft.constant = -50;
}

-(void)callTel
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"呼叫" message:self.model.tel preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [APPLICATION openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model.tel]]];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:sureAction];
    [self.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

@end
