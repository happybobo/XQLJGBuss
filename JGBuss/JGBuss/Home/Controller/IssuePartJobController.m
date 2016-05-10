//
//  IssuePartJobController.m
//  JGBuss
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "IssuePartJobController.h"
#import "UIButton+AFNetworking.h"
#import "UITextView+placeholder.h"
#import "DateOrTimeTool.h"
#import "NameIdManger.h"
#import "QiniuSDK.h"
#import "JGHTTPClient.h"
#import "JGHTTPClient+ManageJob.h"
#import "JGHTTPClient+IssuePartJob.h"
#import "DateOrTimeTool.h"
#import "MerchantModel.h"
#import "DetailModel.h"
#import "JianzhiModel.h"
#import "PeopCountCell.h"
#import "JobAddresCell.h"
#import "TimePickerView.h"
#import "DatePickerView.h"
#import "JobTimeCell.h"
#import "PickerView.h"
#import "PickerCell.h"
#import "HeaderCell.h"
#import "JobDetailCell.h"
#import "BottomBarView.h"
#import <Masonry/Masonry.h>
#import "JianZhiDetailController.h"

@interface IssuePartJobController ()<UITextViewDelegate, UIScrollViewDelegate, UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, ClickBottomBtnDelegate>
{
    UIScrollView *bgScrollView;
    int indexCityId;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *iconView;
@property (nonatomic,copy) NSString *genderId;
@property (nonatomic,copy) NSString *cityId;
@property (nonatomic,copy) NSString *areaId;
@property (nonatomic,copy) NSString *jobHotId;
@property (nonatomic,copy) NSString *settleId;
@property (nonatomic,copy) NSString *termId;
@property (nonatomic,copy) NSString *iconUrl;
@property (nonatomic,copy) NSString *startTimeStamp;

@property (nonatomic,copy) NSString *endTimeStamp;


@property (nonatomic,strong) DetailModel *detailModel;
@property (nonatomic,strong) MerchantModel *mercntModel;
@property (nonatomic,strong) JianzhiModel *jzModel;

@property (nonatomic,strong) UITextField *issCityTF;
@property (nonatomic,strong) UITextField *hotTF;
@property (nonatomic,strong) UITextField *partTypeTF;
@property (nonatomic,strong) UITextField *tittleTf;
/**
 *  结算方式
 */
@property (nonatomic,strong) UITextField *settletpTF;
@property (nonatomic,strong) UITextField *moneyTypeTF;
@property (nonatomic,strong) UITextField *genderTF;
@property (nonatomic,strong) UITextField *peopleCntTF;
@property (nonatomic,strong) UITextField *boyContTF;
@property (nonatomic,strong) UITextField *girlCountTF;
@property (nonatomic,strong) UITextField *jobZoneTF;
@property (nonatomic,strong) UITextField *jobDetAddTF;
@property (nonatomic,strong) UITextField *toPlaceTF;
@property (nonatomic,strong) UITextField *toTimeTF;
@property (nonatomic,strong) UITextField *telTF;
@property (nonatomic,strong) UITextView *jobContTF;
@property (nonatomic,strong) UITextView *jobReqirTF;
@property (nonatomic,strong) UITextField *modelNameTF;


@property (nonatomic,strong) UIButton *startDateTF;
@property (nonatomic,strong) UIButton *endDateTF;
@property (nonatomic,strong) UIButton *startTimeTF;
@property (nonatomic,strong) UIButton *endTimeTF;
@property (nonatomic,strong) UIButton *termBtn;//用这个tag值记录term参数ID
@property (nonatomic,strong) UIButton *areaBtn;//用这个tag值记录area参数ID



@end

@implementation IssuePartJobController

-(DetailModel *)detailModel
{
    if (!_detailModel) {
        _detailModel = [[DetailModel alloc] init];
    }
    return _detailModel;
}
-(JianzhiModel *)jzModel
{
    if (!_jzModel) {
        _jzModel = [[JianzhiModel alloc] init];
    }
    return _jzModel;
}
-(MerchantModel *)mercntModel
{
    if (!_mercntModel) {
        _mercntModel = [[MerchantModel alloc] init];
    }
    return _mercntModel;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        CGFloat height ;
        if (self.genderId.intValue == 31||self.genderId.intValue == 30||self.genderId.intValue == 3) {
            height = 1313+46;
        }else{
            height = 1313;
        }
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, height)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self customHeaderView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(UIView *)customHeaderView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 85)];
    
    UIButton *iconView = [UIButton buttonWithType:UIButtonTypeCustom];
    iconView.showsTouchWhenHighlighted = YES;
    [iconView setBackgroundImage:[UIImage imageNamed:@"img_logo"] forState:UIControlStateNormal];
    iconView.frame = CGRectMake(bgView.center.x-20, 10, 40, 40);
    iconView.layer.cornerRadius = 20;
    iconView.layer.masksToBounds = YES;
    [iconView addTarget:self action:@selector(selectAImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview:iconView];
    self.iconView = iconView;
    if (self.model) {
        
        [self.iconView setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:self.model.name_image] placeholderImage:[UIImage imageNamed:@"chatBar_colorMore_photo"]];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, iconView.bottom+10, SCREEN_W, 20)];
    label.text = @"设置兼职图片";
    label.font = FONT(14);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = LIGHTGRAYTEXT;
    [bgView addSubview:label];
    
    return bgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详情填写";
    
    
    [NotificationCenter addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    CGFloat height ;
    if (self.genderId.intValue == 31||self.genderId.intValue == 30||self.genderId.intValue == 3) {
        height = 1313+46+64;
    }else{
        height = 1313+64;
    }

    bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-49)];
    bgScrollView.contentSize = CGSizeMake(SCREEN_W, height);
    bgScrollView.delegate = self;
    [self.view addSubview:bgScrollView];
    [bgScrollView addSubview:self.tableView];
    
    
    
    [NotificationCenter addObserver:self selector:@selector(receiveTimeStamp:) name:kNotificationSelectWorkDate object:nil];
    
    //如果是来修改兼职的走下边的代码
    if (self.isAlert) {
        
        UIButton *sureAlert = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:sureAlert];
        [sureAlert setTitle:@"确认修改" forState:UIControlStateNormal];
        [sureAlert setBackgroundColor:YELLOWCOLOR];
        [sureAlert addTarget:self action:@selector(sureToAlert:) forControlEvents:UIControlEventTouchUpInside];
        
        [sureAlert mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
            make.height.equalTo(@(49));
            
        }];
        if (!self.model) {
            
            [JGHTTPClient getAjobModelByjobId:self.jobId Success:^(id responseObject) {
                self.model = [HistoryModel mj_objectWithKeyValues:[responseObject[@"data"] objectForKey:@"t_job"] ];
                [self.tableView reloadData];
            } failure:^(NSError *error) {
                
            }];
        }
    }else{
        BottomBarView *barView = [[BottomBarView alloc] init];
        barView.delegate = self;
        barView.backgroundColor = WHITECOLOR;
        barView.layer.shadowOpacity = 0.5;
        barView.layer.shadowOffset = CGSizeMake(0, 1);
        barView.layer.shadowColor = [UIColor blackColor].CGColor;
        [self.view addSubview:barView];
        [barView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
            make.height.equalTo(@(49));
            
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)receiveTimeStamp:(NSNotification *)noti
{
    NSDictionary *dic = noti.object;
    if ([dic[@"type"] intValue] == 0) {
        self.startTimeStamp = dic[@"timeStamp"];
    }else if ([dic[@"type"] intValue] == 1){
        self.endTimeStamp = dic[@"timeStamp"];
    }
}

#pragma mark tableView的组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            return 44;
        }else if (indexPath.row == 1){
            return 330;
        }else{
            return 0;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 6) {
            return 90;
        }else if (indexPath.row == 5){
            if (self.genderId.intValue == 31||self.genderId.intValue == 30||self.genderId.intValue == 3) {
                return 90;
            }
            return 44;
        }
        else{
            return 44;
        }
    }
    else{
        return 44;
    }
}

#pragma mark 每组返回的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:{
            
            return 4;
            
            break;
        } case 1:{
            
            return 9;
            
            break;
        } case 2:{
            
            return 4;
            
            break;
        } case 3:{
            
            return 2;
            
            break;
        }
        default:
            return 0;
            break;
    }

}
#pragma mark 返回header的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
#pragma mark 每一组返回一个header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 25)];
    headerView.backgroundColor = BACKCOLORGRAY;
    return headerView;
}
#pragma mark 返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString * identifier = @"pickerCell";
//    PickerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    PickerCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PickerCell" owner:nil options:nil]lastObject];
    }
    switch (indexPath.section) {
        case 0:{
            
            switch (indexPath.row) {
                case 0:{
                    
                    HeaderCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"HeaderCell" owner:nil options:nil]lastObject];
                    cell.iconView.image = [UIImage imageNamed:@"icon_class"];
                    cell.tittleLabel.text = @"选择分类";
                    return cell;
                    break;
                } case 1:{
                    
                    cell.nameL.text = @"发布区域";
                    cell.selectTF.placeholder = @"请选择发布区域";
                    self.issCityTF = cell.selectTF;
                    if (self.model) {
                        cell.selectTF.text = self.model.city_id_name;
                    }
                    break;
                } case 2:{
                    
                    cell.nameL.text = @"兼职级别";
                    cell.selectTF.placeholder = @"热门/精品/旅行/正常";
                    self.hotTF = cell.selectTF;
                    if (self.model) {
                        cell.selectTF.text = [NameIdManger getHotNameById:self.model.hot];
                    }
                    break;
                }case 3:{
                    
                    cell.nameL.text = @"兼职种类";
                    cell.selectTF.placeholder = @"选择兼职种类";
                    self.partTypeTF = cell.selectTF;
                    if (self.model) {
                        cell.selectTF.text = self.model.type_id_name;
                    }
                    break;
                }
                default:
                    break;
            }
            return cell;
            
            break;
        } case 1:{//基本信息组
            
            switch (indexPath.row) {
                case 0:{
                    
                    HeaderCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"HeaderCell" owner:nil options:nil]lastObject];
                    cell.iconView.image = [UIImage imageNamed:@"icon_normal"];
                    cell.tittleLabel.text = @"基本信息";
                    return cell;

                    
                    break;
                } case 1:{//兼职标题
                    cell.nameL.text = @"兼职标题";
                    cell.selectTF.placeholder = @"请输入兼职标题";
                    cell.selectTF.userInteractionEnabled = YES;
                    self.tittleTf = cell.selectTF;
                    if (self.model) {
                        cell.selectTF.text = self.model.name;
                    }

                    break;
                } case 2:{//结算方式
                    cell.nameL.text = @"结算方式";
                    cell.selectTF.placeholder = @"请选择结算方式";
                    self.settletpTF = cell.selectTF;
                    if (self.model) {
                        cell.selectTF.text = [NameIdManger getModeNameById:self.model.mode];
                    }
                    break;
                } case 3:{//薪资待遇
                    
                    cell.nameL.text = @"薪资待遇";
                    cell.selectTF.placeholder = @"请填写薪资";
                    cell.selectBtn.hidden = NO;
                    self.moneyTypeTF = cell.selectTF;
                    cell.selectTF.userInteractionEnabled = YES;
                    self.termBtn = cell.selectBtn;
                    if (self.model) {
                        [cell.selectBtn setTitle:[NameIdManger getTermNameById:self.model.term] forState:UIControlStateNormal];
                        cell.selectTF.text = self.model.money;
                        cell.selectBtn.tag = self.model.term.intValue;
                    }
                    break;
                } case 4:{//性别限制
                    
                    
                    cell.nameL.text = @"性别限制";
                    cell.selectTF.placeholder = @"请选择是否限制男女";
                    self.genderTF = cell.selectTF;;
                    if (self.model) {
                    
//                        cell.selectTF.text = [NameIdManger getgenderNameById:self.model.limit_sex];
                        
                    }
                    break;
                } case 5:{//录取人数
                    
                    if (self.genderId.intValue == 31||self.genderId.intValue == 30||self.genderId.intValue == 3)
                    {
                        PeopCountCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"PeopCountCell" owner:nil options:nil]lastObject];
                        self.boyContTF = cell.boyCountL;
                        self.girlCountTF = cell.girlCountL;
                        if(self.model){
//                            cell.boyCountL.text = self.model.sum;
//                            if (self.isAlert) {
//                                cell.girlCountL.text = self.model.nv_sum;
//                            }
                        }
                        return cell;
                    }
                    else{
                        PickerCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"PickerCell" owner:nil options:nil]lastObject];
                        cell.nameL.text = @"录取人数";
                        cell.selectTF.placeholder = @"请输入需录取人数";
                        cell.selectTF.userInteractionEnabled = YES;
                        cell.peopeleL.hidden = NO;
                        self.peopleCntTF = cell.selectTF;
                        if (self.model) {
//                            cell.selectTF.text = self.model.sum;
                        }
                        return cell;
                    }
                    
                    break;
                }
                case 6:{//工作地点
                    JobAddresCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    if (!cell) {
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"JobAddresCell" owner:nil options:nil]lastObject];
                    }
                    self.jobZoneTF = cell.selectAddTF;
                    self.jobDetAddTF = cell.inPutDetAddTF;
                    self.areaBtn = cell.selectBtn;
                    if (self.model) {
                        cell.selectAddTF.text = self.model.area_id_name;
                        cell.inPutDetAddTF.text = self.model.address;
                        cell.selectBtn.tag = self.model.area_id.intValue;
                    }
                    cell.cityModels = self.cityModels;
                    return cell;
                    break;
                }
                case (7):{//工作日期
                    JobTimeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    if (!cell) {
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"JobTimeCell" owner:nil options:nil]lastObject];
                    }
                    cell.nameL.text = @"工作日期";
                    [cell.startTimeL setTitle:@"请选择" forState:UIControlStateNormal];
                    [cell.endTimeL setTitle:@"请选择" forState:UIControlStateNormal];
                    self.startDateTF = cell.startTimeL;
                    self.endDateTF = cell.endTimeL;
                    if (self.model) {
                        NSTimeInterval time = self.model.start_date.longLongValue;
                        NSRange range = NSMakeRange(5, 5);
                        NSString *startDateStr = [[DateOrTimeTool getDateStringBytimeStamp:time] substringWithRange:range];
                        [cell.startTimeL setTitle:startDateStr forState:UIControlStateNormal];
                        
                        NSTimeInterval timeEnd = self.model.stop_date.longLongValue;
                        NSString *endDateStr = [[DateOrTimeTool getDateStringBytimeStamp:timeEnd] substringWithRange:range];
                        [cell.endTimeL setTitle:endDateStr forState:UIControlStateNormal];
                        
                    }
                    return cell;
                    break;
                }
                case 8:{//工作时间
                    JobTimeCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"JobTimeCell" owner:nil options:nil]lastObject];
                    cell.nameL.text = @"工作时间";
                    [cell.startTimeL setTitle:@"请选择" forState:UIControlStateNormal];
                    [cell.endTimeL setTitle:@"请选择" forState:UIControlStateNormal];
                    self.startTimeTF = cell.startTimeL;
                    self.endTimeTF = cell.endTimeL;
                    if (self.model) {
                        [cell.startTimeL setTitle:[DateOrTimeTool getWorkTimeStr:self.model.info_start_time] forState:UIControlStateNormal];
                        [cell.endTimeL setTitle:[DateOrTimeTool getWorkTimeStr:self.model.info_stop_time] forState:UIControlStateNormal];
                    }
                    return cell;
                    break;
                }
                default:
                    break;
            }
            return cell;
            
            break;
            
        } case 2:{//招募信息组
            
            switch (indexPath.row) {
                case 0:{
                    
                    HeaderCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"HeaderCell" owner:nil options:nil]lastObject];
                    cell.iconView.image = [UIImage imageNamed:@"icon_recruit"];
                    cell.tittleLabel.text = @"招募信息";
                    return cell;
                    break;
                } case 1:{//集合地点
                    
                    cell.nameL.text = @"集合地点";
                    cell.selectTF.placeholder = @"请输入集合地点";
                    cell.selectTF.userInteractionEnabled = YES;
                    self.toPlaceTF = cell.selectTF;
                    if (self.model) {
                        cell.selectTF.text = self.model.info_set_place;
                    }
                    break;
                } case 2:{//集合时间
                    
                    cell.nameL.text = @"集合时间";
                    cell.selectTF.placeholder = @"请选择集合时间";
                    cell.selectTF.userInteractionEnabled = YES;
                    self.toTimeTF = cell.selectTF;
                    if (self.model) {
                        cell.selectTF.text = self.model.info_set_time;
                    }
                    break;
                } case 3:{//联系电话
                    cell.nameL.text = @"联系电话";
                    cell.selectTF.placeholder = @"请输入您的电话";
                    cell.selectTF.userInteractionEnabled = YES;
                    self.telTF = cell.selectTF;
                    if (self.model) {
                        cell.selectTF.text = self.model.info_tel;
                    }
                    break;
                }
                default:
                    break;
            }
            return cell;
            break;
        } case 3:{//工作详情
            
            switch (indexPath.row) {
                case 0:{
                    
                    HeaderCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"HeaderCell" owner:nil options:nil]lastObject];
                    cell.iconView.image = [UIImage imageNamed:@"icon_ps"];
                    cell.tittleLabel.text = @"工作详情";
                    return cell;
                    
                    break;
                } case 1:{
                    
                    JobDetailCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"JobDetailCell" owner:nil options:nil]lastObject];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    self.jobContTF = cell.jobContentTV;
                    self.jobReqirTF = cell.jobRequireTV;
                    self.jobContTF.delegate = self;
                    self.jobReqirTF.delegate = self;
                    if (self.model) {
                        cell.jobContentTV.text = self.model.info_work_content;
                        cell.jobRequireTV.text = self.model.info_work_require;
                        cell.jobContentTV.placeholder = @"";
                        cell.jobRequireTV.placeholder = @"";
                    }
                    return cell;
                    break;
                }
                default:
                    return nil;
                    break;
            }
            break;
        }
        default:
            return nil;
            break;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    if (indexPath.section == 0) {//选择城市
        if (indexPath.row == 1) {
            PickerView *pickerView = [PickerView aPickerView:^(NSString *city,NSString *Id) {
                self.issCityTF.text = city;
                self.cityId = Id;
                indexCityId = Id.intValue;
                [NotificationCenter postNotificationName:kNotificationSelectCity object:Id];
            }];
            pickerView.dataType = TypeOfCity;
            pickerView.arrayData = self.cityModels;
            [pickerView show];
        }else if (indexPath.row == 2){//选择是不是热门兼职
            PickerView *pickerView = [PickerView aPickerView:^(NSString *str,NSString *Id) {
                self.hotTF.text = str;
                self.jobHotId = Id;
            }];
            pickerView.dataType = TypeOfHot;
            pickerView.arrayData = @[@{@"type":@"普通",@"id":@"0"},@{@"type":@"热门",@"id":@"1"},@{@"type":@"精品",@"id":@"2"},@{@"type":@"旅行",@"id":@"3"}];
            [pickerView show];
        }else if (indexPath.row == 3){//选择兼职种类
            PickerView *pickerView = [PickerView aPickerView:^(NSString *str,NSString *Id) {
                self.partTypeTF.text = str;
                self.jobId = Id;
            }];
            pickerView.dataType = TypeOfJob;
            pickerView.arrayData = self.jobTypes;
            [pickerView show];
        }
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 1:{//输入兼职标题
                
                break;
            } case 2:{//选择结算方式
                
                PickerView *pickerView = [PickerView aPickerView:^(NSString *str,NSString *Id) {
                    self.settletpTF.text = str;
                    self.settleId  = Id;
                }];
                pickerView.dataType = TypeOfSettle;
                pickerView.arrayData = @[@{@"type":@"月结",@"id":@"0"},@{@"type":@"周结",@"id":@"1"},@{@"type":@"日结",@"id":@"2"},@{@"type":@"旅行",@"id":@"3"}];
                [pickerView show];

                break;
            } case 3:{//输入工资
              
                
                break;
            } case 4:{//性别限制
                
                PickerView *pickerView = [PickerView aPickerView:^(NSString *str,NSString *Id) {
                    
                    self.genderTF.text = str;
                    self.genderId = Id;
                    self.tableView.scrollEnabled = NO;
                    
                        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
                    if (Id.intValue == 3) {//选择男女都限制
                        self.tableView.frame = CGRectMake(0, 0, SCREEN_W, 1313+46);
                        bgScrollView.contentSize = CGSizeMake(SCREEN_W, 1313+64+46);
                    }else{
                        self.tableView.frame = CGRectMake(0, 0, SCREEN_W, 1313);
                        bgScrollView.contentSize = CGSizeMake(SCREEN_W, 1313+64);
                    }
                    
                }];
                pickerView.dataType = TypeOfGender;
                pickerView.arrayData = @[@{@"type":@"只招女",@"id":@"0"},@{@"type":@"只招男",@"id":@"1"},@{@"type":@"不限男女",@"id":@"2"},@{@"type":@"男女各限",@"id":@"3"}];
                [pickerView show];

                
                break;
            } case 5:{
                
                
                
                break;
            } case 6:{
                
                
                
                break;
            }
            default:
                break;
        }

    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//去掉 UItableview headerview 黏性(sticky)//其实就是改变了悬停的位置而已
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [self.view endEditing:YES];
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = 15; //sectionHeaderHeight
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 50, 0);
        }
    }
}

#pragma mark 选择一张兼职图片
-(void)selectAImage:(UIButton *)iconBtn
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择",nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.allowsEditing = NO;//不允许裁剪图片
    imagePickerController.delegate = self;
    
    switch (buttonIndex) {
        case 0:
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            } else {
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            break;
        case 1:
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        default:
            return;
    }
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    JGLog(@"%@",info);
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
//    JGLog(@" 压缩前  width ==  %f    height === %f ",image.size.width,image.size.height);
    
    //压缩图片
    image = [self imageByScalingAndCroppingForSize:CGSizeMake(image.size.width/8, image.size.height/8) sourceImage:image];
    
//    JGLog(@" 压缩后   width ==  %f    height === %f ",image.size.width,image.size.height);
    NSData *data = UIImageJPEGRepresentation(image, 0.5);

    JGLog(@"%lu",(unsigned long)data.length);
    if(image.imageOrientation != UIImageOrientationUp)
    {
        // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
        // 以下为调整图片角度的部分
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 调整图片角度完毕
    }
    [self.iconView setBackgroundImage:image forState:UIControlStateNormal];
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    NSData *dataFront= UIImageJPEGRepresentation(image,0.5);
    [upManager putData:dataFront key:nil token:[USERDEFAULTS objectForKey:@"QNtoken"]
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  //                      NSLog(@"%@-------------", resp);
                  //上传图片到服务器
                  if (resp == nil) {
                      [self showAlertViewWithText:@"上传图片失败" duration:1];
                      return ;
                  }
                  self.iconUrl = [@"http://7xlell.com2.z0.glb.qiniucdn.com/" stringByAppendingString:[resp objectForKey:@"key"]];
        } option:nil];

    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
//图片压缩到指定大小
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize sourceImage:(UIImage *)sourceImage
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark 预览兼职详情
-(void)previewAPartJobDetail
{
    [self createModel];
    JianZhiDetailController *detailVC = [[JianZhiDetailController alloc] init];
    detailVC.detailModel = self.detailModel;
    detailVC.merchantModel = self.mercntModel;
    detailVC.jzModel = self.jzModel;
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark 保存为模板
-(void)saveForModule
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入模板名称" message:@"不要输入空格等符号" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (!self.cityId.length) {
            [self showAlertViewWithText:@"请选择城市" duration:1];
            return;
        }else if (self.areaBtn.tag==0){[self showAlertViewWithText:@"请选择工作地点" duration:1];
            return;
        }else if (!self.jobId.length){[self showAlertViewWithText:@"请选择工作种类" duration:1];
            return;
        }else if (!self.tittleTf.text.length){[self showAlertViewWithText:@"请填写兼职标题" duration:1];
            return;
        }else if (!self.startTimeStamp.length){[self showAlertViewWithText:@"请选择开始工作时间" duration:1];
            return;
        }else if (!self.endTimeStamp.length){[self showAlertViewWithText:@"请选择结束工作时间" duration:1];
            return;
        }else if (!self.jobDetAddTF.text.length){[self showAlertViewWithText:@"请填写工作的具体地点" duration:1];
            return;
        }else if (!self.settleId.length){[self showAlertViewWithText:@"请选择结算方式" duration:1];
            return;
        }else if (!self.moneyTypeTF.text.length){[self showAlertViewWithText:@"请填写工资钱数" duration:1];
            return;
        }else if (self.termBtn.tag != 0&&self.termBtn.tag != 1&&self.termBtn.tag != 2&&self.termBtn.tag != 3&&self.termBtn.tag != 4&&self.termBtn.tag != 5){[self showAlertViewWithText:@"请选择工资计算方式" duration:1];
            return;
        }else if (!self.genderId.length||!self.genderTF.text.length){[self showAlertViewWithText:@"请选择性别限制" duration:1];
            return;
        }else if (!self.jobId.length){[self showAlertViewWithText:@"请选择工作种类" duration:1];
            return;
        }else if (self.telTF.text.length!=11){[self showAlertViewWithText:@"请正确输入手机号" duration:1];
            return;
        }else if (!self.startTimeTF.titleLabel.text.length){[self showAlertViewWithText:@"请选择工作开始时间" duration:1];
            return;
        }else if (!self.endTimeTF.titleLabel.text.length){[self showAlertViewWithText:@"请选择工作结束时间" duration:1];
            return;
        }else if (!self.toPlaceTF.text.length){[self showAlertViewWithText:@"请填写集合地点" duration:1];
            return;
        }else if (!self.toTimeTF.text.length){[self showAlertViewWithText:@"请填写集合时间" duration:1];
            return;
        }else if (!self.jobContTF.text.length){[self showAlertViewWithText:@"请填写工作内容" duration:1];
            return;
        }else if (!self.jobReqirTF.text.length){[self showAlertViewWithText:@"请填写工作要求" duration:1];
            return;
        }
        [self postGenderLimitInfo:nil];
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        self.modelNameTF = textField;
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark 发布兼职
-(void)issueAPartJob
{
    if (!self.cityId.length) {
        [self showAlertViewWithText:@"请选择城市" duration:1];
        return;
    }else if (self.areaBtn.tag==0){[self showAlertViewWithText:@"请选择工作地点" duration:1];
        return;
    }else if (!self.jobId.length){[self showAlertViewWithText:@"请选择工作种类" duration:1];
        return;
    }else if (!self.tittleTf.text.length){[self showAlertViewWithText:@"请填写兼职标题" duration:1];
        return;
    }else if (!self.startTimeStamp.length){[self showAlertViewWithText:@"请选择开始工作时间" duration:1];
        return;
    }else if (!self.endTimeStamp.length){[self showAlertViewWithText:@"请选择结束工作时间" duration:1];
        return;
    }else if (!self.jobDetAddTF.text.length){[self showAlertViewWithText:@"请填写工作的具体地点" duration:1];
        return;
    }else if (!self.settleId.length){[self showAlertViewWithText:@"请选择结算方式" duration:1];
        return;
    }else if (!self.moneyTypeTF.text.length){[self showAlertViewWithText:@"请填写工资钱数" duration:1];
        return;
    }else if (self.termBtn.tag != 0&&self.termBtn.tag != 1&&self.termBtn.tag != 2&&self.termBtn.tag != 3&&self.termBtn.tag != 4&&self.termBtn.tag != 5){[self showAlertViewWithText:@"请选择工资计算方式" duration:1];
        return;
    }else if (!self.genderId.length||!self.genderTF.text.length){
        [self showAlertViewWithText:@"请选择性别限制" duration:1];
        return;
    }else if (!self.jobId.length){[self showAlertViewWithText:@"请选择工作种类" duration:1];
        return;
    }else if (self.telTF.text.length!=11){[self showAlertViewWithText:@"请正确输入手机号" duration:1];
        return;
    }else if (!self.startTimeTF.titleLabel.text.length){[self showAlertViewWithText:@"请选择工作开始时间" duration:1];
        return;
    }else if (!self.endTimeTF.titleLabel.text.length){[self showAlertViewWithText:@"请选择工作结束时间" duration:1];
        return;
    }else if (!self.toPlaceTF.text.length){[self showAlertViewWithText:@"请填写集合地点" duration:1];
        return;
    }else if (!self.toTimeTF.text.length){[self showAlertViewWithText:@"请填写集合时间" duration:1];
        return;
    }else if (!self.jobContTF.text.length){[self showAlertViewWithText:@"请填写工作内容" duration:1];
        return;
    }else if (!self.jobReqirTF.text.length){[self showAlertViewWithText:@"请填写工作要求" duration:1];
        return;
    }
    
    if (self.genderId.intValue != 30&&self.genderId.intValue != 31&&self.genderId.intValue != 3) {
        if (!self.peopleCntTF.text.length||[self.peopleCntTF.text isEqualToString:@"0"]){
            [self showAlertViewWithText:@"请填写招募人数" duration:1];
            return;
        }
        [JGHTTPClient postPartJobInfoBycityId:self.cityId areaId:[NSString stringWithFormat:@"%ld",self.areaBtn.tag] typeId:self.jobId merntId:USER.Id tittle:self.tittleTf.text iconUrl:self.iconUrl startDate:self.startTimeStamp endDate:self.endTimeStamp address:self.jobDetAddTF.text settleType:self.settleId money:self.moneyTypeTF.text term:[NSString stringWithFormat:@"%ld",self.termBtn.tag] gender:self.genderId peopleSum:self.peopleCntTF.text partjobType:self.jobHotId alike:@"0" tel:self.telTF.text startTime:self.startTimeTF.titleLabel.text endTime:self.endTimeTF.titleLabel.text togetherPlace:self.toPlaceTF.text togetherTime:self.toTimeTF.text jobCont:self.jobContTF.text jobReqir:self.jobReqirTF.text jobModel:@"0" Success:^(id responseObject) {
            [self showAlertViewWithText:responseObject[@"message"] duration:1];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        } failure:^(NSError *error) {
            [self showAlertViewWithText:NETERROETEXT duration:1];
        }];

    }else{//男女都限制的时候
        
        NSString *alike = [self getTimeStamp];
        [self postGenderLimitInfo:alike];
    }
}

-(void)postGenderLimitInfo:(NSString *)alike
{
    if (!alike) {//保存模板
        [JGHTTPClient postPartJobInfoBycityId:self.cityId areaId:[NSString stringWithFormat:@"%ld",self.areaBtn.tag] typeId:self.jobId merntId:USER.Id tittle:self.tittleTf.text iconUrl:self.iconUrl startDate:self.startTimeStamp endDate:self.endTimeStamp address:self.jobDetAddTF.text settleType:self.settleId money:self.moneyTypeTF.text term:[NSString stringWithFormat:@"%ld",self.termBtn.tag] gender:[NSString stringWithFormat:@"%@",self.genderId] peopleSum:@"0" partjobType:self.jobHotId alike:@"0" tel:self.telTF.text startTime:self.startTimeTF.titleLabel.text endTime:self.endTimeTF.titleLabel.text togetherPlace:self.toPlaceTF.text togetherTime:self.toTimeTF.text jobCont:self.jobContTF.text jobReqir:self.jobReqirTF.text jobModel:self.modelNameTF.text Success:^(id responseObject) {
            [self showAlertViewWithText:@"保存模板成功" duration:1];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
//                if (self.refreshBlock) {
//                    self.refreshBlock();
//                }
            });
        } failure:^(NSError *error) {
            [self showAlertViewWithText:NETERROETEXT duration:1];
        }];

        return;
    }
    for (int i=0; i<2; i++) {
        if (i==0) {//传男性数据
            if (!self.boyContTF.text.length||[self.boyContTF.text isEqualToString:@"0"]){[self showAlertViewWithText:@"请填写招募男生人数" duration:1];
                return;
            }
            if (!self.girlCountTF.text.length||[self.girlCountTF.text isEqualToString:@"0"]){[self showAlertViewWithText:@"请填写招募女生人数" duration:1];
                return;
            }
            [JGHTTPClient postPartJobInfoBycityId:self.cityId areaId:[NSString stringWithFormat:@"%ld",self.areaBtn.tag] typeId:self.jobId merntId:USER.Id tittle:self.tittleTf.text iconUrl:self.iconUrl startDate:self.startTimeStamp endDate:self.endTimeStamp address:self.jobDetAddTF.text settleType:self.settleId money:self.moneyTypeTF.text term:[NSString stringWithFormat:@"%ld",self.termBtn.tag] gender:[NSString stringWithFormat:@"31"] peopleSum:self.boyContTF.text partjobType:self.jobHotId alike:alike tel:self.telTF.text startTime:self.startTimeTF.titleLabel.text endTime:self.endTimeTF.titleLabel.text togetherPlace:self.toPlaceTF.text togetherTime:self.toTimeTF.text jobCont:self.jobContTF.text jobReqir:self.jobReqirTF.text jobModel:@"0" Success:^(id responseObject) {
                [self showAlertViewWithText:responseObject[@"message"] duration:1];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            } failure:^(NSError *error) {
                [self showAlertViewWithText:NETERROETEXT duration:1];
            }];
        }else{
            [JGHTTPClient postPartJobInfoBycityId:self.cityId areaId:[NSString stringWithFormat:@"%ld",self.areaBtn.tag] typeId:self.jobId merntId:USER.Id tittle:self.tittleTf.text iconUrl:self.iconUrl startDate:self.startTimeStamp endDate:self.endTimeStamp address:self.jobDetAddTF.text settleType:self.settleId money:self.moneyTypeTF.text term:[NSString stringWithFormat:@"%ld",self.termBtn.tag] gender:[NSString stringWithFormat:@"30"] peopleSum:self.girlCountTF.text partjobType:self.jobHotId alike:alike tel:self.telTF.text startTime:self.startTimeTF.titleLabel.text endTime:self.endTimeTF.titleLabel.text togetherPlace:self.toPlaceTF.text togetherTime:self.toTimeTF.text jobCont:self.jobContTF.text jobReqir:self.jobReqirTF.text jobModel:@"0" Success:^(id responseObject) {
                [self showAlertViewWithText:responseObject[@"message"] duration:1];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            } failure:^(NSError *error) {
                [self showAlertViewWithText:NETERROETEXT duration:1];
            }];

        }
    }
}

-(void)createModel
{
    self.detailModel.start_date = self.startDateTF.titleLabel.text;
    self.detailModel.stop_date = self.endDateTF.titleLabel.text;
    self.detailModel.start_time = self.startTimeTF.titleLabel.text;
    self.detailModel.stop_time = self.endTimeTF.titleLabel.text;
    self.detailModel.work_content = self.jobContTF.text;
    self.detailModel.work_require = self.jobReqirTF.text;
    self.detailModel.address = self.jobZoneTF.text;
    self.detailModel.set_place = self.toPlaceTF.text;
    self.detailModel.set_time = self.toTimeTF.text;
    self.detailModel.mode = self.settleId;
    self.detailModel.limit_sex = self.genderId;
    self.detailModel.other = @"";
    self.detailModel.id = @"1";
    self.detailModel.lon = @"";
    self.detailModel.lat = @"";
    self.detailModel.job_id = @"";
    self.detailModel.is_collection = @"yulan";
    
    self.mercntModel.name = self.tittleTf.text;
    self.mercntModel.name_image = USER.name_image;
    self.mercntModel.post = @"30";
    
    self.jzModel.sum = self.peopleCntTF.text;
    self.jzModel.term = [NSString stringWithFormat:@"%ld",self.termBtn.tag];
    self.jzModel.count = @"0";
    self.jzModel.money = self.moneyTypeTF.text;
    self.jzModel.name_image = self.iconUrl;
    self.jzModel.start_date = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    self.jzModel.name = self.tittleTf.text;
}
//获取本地时间戳
- (NSString *)getTimeStamp {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    //long long debuggTime=[[UserDefaultsManager getTimeSpan] longLongValue]+dTime;
    NSString *timeStamp=[NSString stringWithFormat:@"%lld",(long long)time];
    return timeStamp;
}
-(void)setModel:(HistoryModel *)model
{
    _model = model;
//    if (model.limit_sex.intValue == 31||model.limit_sex.intValue == 30||model.limit_sex.intValue == 3) {
//        self.genderId = model.limit_sex;
//    }else{
//        self.genderId = model.limit_sex;
//    }
    self.cityId = model.city_id;
    self.areaId = model.area_id;
    self.jobId = model.type_id;
    self.jobHotId = model.hot;
    self.settleId = model.mode;
    self.termId = model.term;
    self.iconUrl = model.name_image;
    self.startTimeStamp = model.start_date;
    self.endTimeStamp = model.stop_date;
//    self.areaBtn.tag = model.area_id.intValue;
//    self.termBtn.tag = model.term.intValue;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
//    if (textView == self.jobContTF) {
//        CGRect rect = self.tableView.frame;
//        rect.origin.y -= 200;
//        self.tableView.frame = rect;
//    }
}

-(void)keyboardShow:(NSNotification *)noti
{
    // 取出键盘最终的frame
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 取出键盘弹出需要花费的时间
    double duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 修改transform
    [UIView animateWithDuration:duration animations:^{
        CGFloat ty = [UIScreen mainScreen].bounds.size.height - rect.origin.y;
        self.view.transform = CGAffineTransformMakeTranslation(0, - ty);
    }];
}

/**
 *  确认修改
 */
-(void)sureToAlert:(UIButton *)btn
{
    if (!self.cityId.length) {
        [self showAlertViewWithText:@"请选择城市" duration:1];
        return;
    }else if (self.areaBtn.tag==0){[self showAlertViewWithText:@"请选择工作地点" duration:1];
        return;
    }else if (!self.jobId.length){[self showAlertViewWithText:@"请选择工作种类" duration:1];
        return;
    }else if (!self.tittleTf.text.length){[self showAlertViewWithText:@"请填写兼职标题" duration:1];
        return;
    }else if (!self.startTimeStamp.length){[self showAlertViewWithText:@"请选择开始工作时间" duration:1];
        return;
    }else if (!self.endTimeStamp.length){[self showAlertViewWithText:@"请选择结束工作时间" duration:1];
        return;
    }else if (!self.jobDetAddTF.text.length){[self showAlertViewWithText:@"请填写工作的具体地点" duration:1];
        return;
    }else if (!self.settleId.length){[self showAlertViewWithText:@"请选择结算方式" duration:1];
        return;
    }else if (!self.moneyTypeTF.text.length){[self showAlertViewWithText:@"请填写工资钱数" duration:1];
        return;
    }else if (self.termBtn.tag != 0&&self.termBtn.tag != 1&&self.termBtn.tag != 2&&self.termBtn.tag != 3&&self.termBtn.tag != 4&&self.termBtn.tag != 5&&self.termBtn.tag != 6){[self showAlertViewWithText:@"请选择工资计算方式" duration:1];
        return;
    }else if (!self.genderId.length||!self.genderTF.text.length){
        [self showAlertViewWithText:@"请选择性别限制" duration:1];
        return;
    }else if (!self.jobId.length){[self showAlertViewWithText:@"请选择工作种类" duration:1];
        return;
    }else if (self.telTF.text.length!=11){[self showAlertViewWithText:@"请正确输入手机号" duration:1];
        return;
    }else if (!self.startTimeTF.titleLabel.text.length){[self showAlertViewWithText:@"请选择工作开始时间" duration:1];
        return;
    }else if (!self.endTimeTF.titleLabel.text.length){[self showAlertViewWithText:@"请选择工作结束时间" duration:1];
        return;
    }else if (!self.toPlaceTF.text.length){[self showAlertViewWithText:@"请填写集合地点" duration:1];
        return;
    }else if (!self.toTimeTF.text.length){[self showAlertViewWithText:@"请填写集合时间" duration:1];
        return;
    }else if (!self.jobContTF.text.length){[self showAlertViewWithText:@"请填写工作内容" duration:1];
        return;
    }else if (!self.jobReqirTF.text.length){[self showAlertViewWithText:@"请填写工作要求" duration:1];
        return;
    }
    
    if (self.genderId.intValue != 30&&self.genderId.intValue != 31&&self.genderId.intValue != 3) {
        if (!self.peopleCntTF.text.length||[self.peopleCntTF.text isEqualToString:@"0"]){
            [self showAlertViewWithText:@"请填写招募人数" duration:1];
            return;
        }
        [JGHTTPClient alertJobInfoBycityId:self.cityId areaId:[NSString stringWithFormat:@"%ld",self.areaBtn.tag] typeId:self.jobId merntId:USER.Id tittle:self.tittleTf.text iconUrl:self.iconUrl startDate:self.startTimeStamp endDate:self.endTimeStamp address:self.jobDetAddTF.text settleType:self.settleId money:self.moneyTypeTF.text term:[NSString stringWithFormat:@"%ld",self.termBtn.tag] gender:self.genderId peopleSum:self.peopleCntTF.text partjobType:self.jobHotId alike:self.model.alike tel:self.telTF.text startTime:self.startTimeTF.titleLabel.text endTime:self.endTimeTF.titleLabel.text togetherPlace:self.toPlaceTF.text togetherTime:self.toTimeTF.text jobCont:self.jobContTF.text jobReqir:self.jobReqirTF.text jobId:self.model.id Success:^(id responseObject) {
            [self showAlertViewWithText:responseObject[@"message"] duration:1];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(NSError *error) {
            [self showAlertViewWithText:NETERROETEXT duration:1];
        }];
    }else{
        if (!self.boyContTF.text.length||[self.boyContTF.text isEqualToString:@"0"]){[self showAlertViewWithText:@"请填写招募男生人数" duration:1];
            return;
        }
        if (!self.girlCountTF.text.length||[self.girlCountTF.text isEqualToString:@"0"]){[self showAlertViewWithText:@"请填写招募女生人数" duration:1];
            return;
        }
        [JGHTTPClient alertJobInfoBycityId:self.cityId areaId:[NSString stringWithFormat:@"%ld",self.areaBtn.tag] typeId:self.jobId merntId:USER.Id tittle:self.tittleTf.text iconUrl:self.iconUrl startDate:self.startTimeStamp endDate:self.endTimeStamp address:self.jobDetAddTF.text settleType:self.settleId money:self.moneyTypeTF.text term:[NSString stringWithFormat:@"%ld",self.termBtn.tag] gender:@"31" peopleSum:self.boyContTF.text partjobType:self.jobHotId alike:self.model.alike tel:self.telTF.text startTime:self.startTimeTF.titleLabel.text endTime:self.endTimeTF.titleLabel.text togetherPlace:self.toPlaceTF.text togetherTime:self.toTimeTF.text jobCont:self.jobContTF.text jobReqir:self.jobReqirTF.text jobId:self.model.id Success:^(id responseObject) {
            [self showAlertViewWithText:responseObject[@"message"] duration:1];
        } failure:^(NSError *error) {
            [self showAlertViewWithText:NETERROETEXT duration:1];
        }];
        [JGHTTPClient alertJobInfoBycityId:self.cityId areaId:[NSString stringWithFormat:@"%ld",self.areaBtn.tag] typeId:self.jobId merntId:USER.Id tittle:self.tittleTf.text iconUrl:self.iconUrl startDate:self.startTimeStamp endDate:self.endTimeStamp address:self.jobDetAddTF.text settleType:self.settleId money:self.moneyTypeTF.text term:[NSString stringWithFormat:@"%ld",self.termBtn.tag] gender:@"30" peopleSum:self.girlCountTF.text partjobType:self.jobHotId alike:self.model.alike tel:self.telTF.text startTime:self.startTimeTF.titleLabel.text endTime:self.endTimeTF.titleLabel.text togetherPlace:self.toPlaceTF.text togetherTime:self.toTimeTF.text jobCont:self.jobContTF.text jobReqir:self.jobReqirTF.text jobId:self.model.nv_job_id Success:^(id responseObject) {
            [self showAlertViewWithText:responseObject[@"message"] duration:1];
        } failure:^(NSError *error) {
            [self showAlertViewWithText:NETERROETEXT duration:1];
        }];
        
    }

}


-(void)dealloc
{
    [NotificationCenter removeObserver:self name:kNotificationSelectWorkDate object:nil];
    [NotificationCenter removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}
@end
