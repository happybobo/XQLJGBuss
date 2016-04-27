//
//  PickerView.m
//  driverapp_iOS
//
//  Created by 江海天 on 15/7/20.
//  Copyright (c) 2015年 dasmaster. All rights reserved.
//

#import "PickerView.h"
#import "NSDate+Addition.h"
#import "CityModel.h"
#import "AreaModel.h"
#import "PartTypeModel.h"

@interface PickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
	void (^_block)(NSString *,NSString*);
	NSArray *_arrayProvince;
}
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *boardView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

@end

@implementation PickerView

+(PickerView *)aPickerView:(void (^)(NSString *str,NSString *Id))block
{
	PickerView *view = [[[NSBundle mainBundle] loadNibNamed:@"PickerView" owner:nil options:nil] lastObject];
	view->_arrayProvince = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"]];
	view->_block = block;
   	return view;
}

- (void)awakeFromNib
{
	self.backgroundColor = RGBACOLOR(0, 0, 0, 0);
    self.datePickerView.datePickerMode = UIDatePickerModeDate;
	self.datePickerView.maximumDate = [NSDate date];
	self.datePickerView.minimumDate = [NSDate stringToDate:@"1940-01-01" format:@"yyyy-MM-dd"];
	NSString *timeString = @"1980-01-01";
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	self.datePickerView.date = [formatter dateFromString:timeString];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self cancel:nil];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	if (self.isCityPicker) {
		return 2;
	}
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if (self.isCityPicker) {
		if(component == 0) {
			return _arrayProvince.count;
		} else {
			NSArray *arrayCity = _arrayProvince[[pickerView selectedRowInComponent:0]][@"cities"];
			return arrayCity.count;
		}
	}
	return [self.arrayData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if (self.isCityPicker) {
		if(component == 0) {
			return _arrayProvince[row][@"name"];
		} else {
			NSArray *arrayCity = _arrayProvince[[pickerView selectedRowInComponent:0]][@"cities"];
			if (row <= [arrayCity count] - 1) {
				return arrayCity[row];
			} else {
				return @"...";
			}
		}
	}
    if (self.dataType == TypeOfCity) {
        CityModel *model = self.arrayData[row];
        return model.city;
    }else if (self.dataType == TypeOfJob){
        PartTypeModel *model = self.arrayData[row];
        return model.type_name;
    }else if (self.dataType == TypeOfArea){
        AreaModel *model = self.arrayData[row];
        return model.area_name;
    }else if (self.dataType == TypeOfHot){
        NSDictionary *dic = self.arrayData[row];
        return dic[@"type"];
    }else if (self.dataType == TypeOfSettle){
        NSDictionary *dic = self.arrayData[row];
        return dic[@"type"];
    }else if (self.dataType == TypeOfTerm){
        NSDictionary *dic = self.arrayData[row];
        return dic[@"type"];
    }else if (self.dataType == TypeOfGender){
        NSDictionary *dic = self.arrayData[row];
        return dic[@"type"];
    }
	return self.arrayData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if (component == 0 && self.isCityPicker) {
		[pickerView reloadComponent:1];
		[pickerView selectRow:0 inComponent:1 animated:YES];
	}
}

- (void)show
{
	if (self.isDatePicker) {
		self.pickerView.hidden = YES;
	} else {
		self.datePickerView.hidden = YES;
	}
	self.frame = [UIApplication sharedApplication].keyWindow.bounds;
	self.boardView.transform = CGAffineTransformMakeTranslation(0, self.boardView.height);
	[[UIApplication sharedApplication].keyWindow addSubview:self];
	[UIView animateWithDuration:0.3f animations:^{
		
		self.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
		self.boardView.transform = CGAffineTransformIdentity;
	}];
}

-(void)dismiss
{
	[UIView animateWithDuration:0.3 animations:^{
		self.backgroundColor = RGBACOLOR(0, 0, 0, 0);
		self.boardView.transform = CGAffineTransformMakeTranslation(0, self.boardView.height);
	} completion:^(BOOL finished) {
		_block = nil;
		[self removeFromSuperview];
	}];
}

- (IBAction)done:(id)sender {
	if (_block) {
		if (self.isDatePicker) {
			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setDateFormat:@"yyyy-MM-dd"];
			_block([dateFormatter stringFromDate:self.datePickerView.date],@"");
			
		} else if (self.isCityPicker) {
			NSString *province = _arrayProvince[[self.pickerView selectedRowInComponent:0]][@"name"];
			NSString *city = _arrayProvince[[self.pickerView selectedRowInComponent:0]][@"cities"][[self.pickerView selectedRowInComponent:1]];
			_block(city,@"");
		} else {
            if (self.dataType == TypeOfCity) {
                CityModel *model = self.arrayData[[self.pickerView selectedRowInComponent:0]];
                _block(model.city,model.id);
            }else if (self.dataType == TypeOfJob){
                PartTypeModel *model = self.arrayData[[self.pickerView selectedRowInComponent:0]];
                _block(model.type_name,model.id);
            }else if (self.dataType == TypeOfArea){
                AreaModel *model = self.arrayData[[self.pickerView selectedRowInComponent:0]];
                _block(model.area_name,model.id);
            }else if (self.dataType == TypeOfHot){
                NSDictionary *dic = self.arrayData[[self.pickerView selectedRowInComponent:0]];
                _block(dic[@"type"],dic[@"id"]);
            }else if (self.dataType == TypeOfSettle){
                NSDictionary *dic = self.arrayData[[self.pickerView selectedRowInComponent:0]];
                _block(dic[@"type"],dic[@"id"]);
            }else if (self.dataType == TypeOfTerm){
                NSDictionary *dic = self.arrayData[[self.pickerView selectedRowInComponent:0]];
                _block(dic[@"type"],dic[@"id"]);
            }else if (self.dataType == TypeOfGender){
                NSDictionary *dic = self.arrayData[[self.pickerView selectedRowInComponent:0]];
                _block(dic[@"type"],dic[@"id"]);
            }
            else{
                _block(_arrayData[[self.pickerView selectedRowInComponent:0]],@"");
            }
		}
	}
	[self dismiss];
}
- (IBAction)cancel:(id)sender {
	[self dismiss];
}

@end
