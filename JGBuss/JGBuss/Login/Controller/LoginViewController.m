//
//  LoginViewController.m
//  JGBuss
//
//  Created by apple on 16/3/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "MyTabBarController.h"
#import "JGHTTPClient+Login.h"
#import "CoreLaunchCool.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UIScrollView *backScrollView;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UITextField *phoneTf;
@property (nonatomic,strong) UITextField *passTf;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"登录";
    self.view.backgroundColor = BACKCOLORGRAY;
    
//    self.view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
//    self.view.backgroundColor = RGBCOLOR(241, 241, 241);
//    self.view.scrollEnabled = NO;
//    self.view.bounces = YES;
//    [self.view addSubview:self.view];
    
    [self configUI];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]};
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setTranslucent:YES];
}

/**
 *  布局UI
 */
-(void)configUI
{
    JGLog(@"%f",SCREEN_H/568);
    //头部ImageView
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 250*(SCREEN_H/667))];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:@"bg-chahua"];
    [self.view addSubview:imageView];
    
    //手机号和密码输入
    UIView *phoneAndPassView = [[UIView alloc] initWithFrame:CGRectMake(0, imageView.bottom, SCREEN_W, 90)];
    
    phoneAndPassView.backgroundColor = WHITECOLOR;
    
    [self.view addSubview:phoneAndPassView];
    
    UIImageView *phoneImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    phoneImg.image = [UIImage imageNamed:@"icon-photo"];
    [phoneAndPassView addSubview:phoneImg];
    
    UITextField *phoneTf = [[UITextField alloc] initWithFrame:CGRectMake(phoneImg.right, 5, SCREEN_W-40, 40)];
    phoneTf.placeholder = @"请输入您的手机号";
    phoneTf.delegate = self;
    phoneTf.keyboardType = UIKeyboardTypeDefault;
    [phoneTf addTarget:self action:@selector(ensureRightInPut:) forControlEvents:UIControlEventEditingChanged];
    phoneTf.font = [UIFont systemFontOfSize:14];
    [phoneAndPassView addSubview:phoneTf];
    self.phoneTf = phoneTf;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(phoneImg.right/2, phoneImg.bottom+5, SCREEN_W-phoneImg.right/2, 1)];
    lineView.backgroundColor = BACKCOLORGRAY;
    [phoneAndPassView addSubview:lineView];
    
    
    UIImageView *passImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, phoneImg.bottom+10, 30, 30)];
    passImg.image = [UIImage imageNamed:@"icon-password"];
    [phoneAndPassView addSubview:passImg];
    
    UITextField *passTf = [[UITextField alloc] initWithFrame:CGRectMake(passImg.right, phoneTf.bottom, SCREEN_W-160, 40)];
    passTf.placeholder = @"密码";
    passTf.delegate = self;
    passTf.returnKeyType = UIReturnKeyDone;
    passTf.secureTextEntry = YES;
    passTf.keyboardType = UIKeyboardTypeDefault;
    [passTf addTarget:self action:@selector(ensureRightInPut:) forControlEvents:UIControlEventEditingChanged];
    //    [passTf setTextColor:LIGHTGRAYTEXT];
    passTf.font = [UIFont systemFontOfSize:14];
    [phoneAndPassView addSubview:passTf];
    self.passTf = passTf;
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(passTf.right, phoneTf.bottom+5, 120, 30);
    [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    //    [forgetBtn setTintColor:LIGHTGRAYTEXT];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [forgetBtn addTarget:self action:@selector(forgetPassWord:) forControlEvents:UIControlEventTouchUpInside];
    [forgetBtn setTitleColor:LIGHTGRAYTEXT forState:UIControlStateNormal];
//    [phoneAndPassView addSubview:forgetBtn];
    
    
    //使用”手机验证码登录“的按钮
    UIButton *btnCode = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCode setTitleColor:LIGHTGRAYTEXT forState:UIControlStateNormal];
    btnCode.frame = CGRectMake(SCREEN_W-120, phoneAndPassView.bottom, 120, 50);
    [btnCode setTitle:@"使用手机验证码登录" forState:UIControlStateNormal];
//    [btnCode addTarget:self action:@selector(loginByPhoneNumAndCode:) forControlEvents:UIControlEventTouchUpInside];
    btnCode.titleLabel.font = [UIFont systemFontOfSize:12];
//    [self.view addSubview:btnCode];
    
    //登录&注册按钮
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 20;
    [loginBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    loginBtn.frame = CGRectMake(30, btnCode.bottom, SCREEN_W-60, 40);
    [loginBtn addTarget:self action:@selector(loginByTelNum:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:YELLOWCOLOR];
    [self.view addSubview:loginBtn];
    self.loginBtn = loginBtn;
    
//    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    registerBtn.layer.masksToBounds = YES;
//    [registerBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
//    registerBtn.layer.cornerRadius = 20;
//    registerBtn.frame = CGRectMake(30, loginBtn.bottom+10, SCREEN_W-60, 40);
//    [registerBtn addTarget:self action:@selector(gotoRegisterVC:) forControlEvents:UIControlEventTouchUpInside];
//    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
//    [registerBtn setBackgroundColor:RGBCOLOR(192, 192, 192)];
//    [self.view addSubview:registerBtn];
    
    
    //第三方登录
//    UIView *thirdloginView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H-120, SCREEN_W, 120)];
//    thirdloginView.backgroundColor = BACKCOLORGRAY;
////    [self.view addSubview:thirdloginView];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_W, 30)];
//    label.text = @"使用其它账号登录";
//    label.textColor = LIGHTGRAYTEXT;
//    label.font = [UIFont systemFontOfSize:12];
//    label.textAlignment = NSTextAlignmentCenter;
//    [thirdloginView addSubview:label];
//    
//    
//    
//    UIButton *wxbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    wxbtn.frame = CGRectMake(thirdloginView.center.x-45, label.bottom, 35, 35);
//    [wxbtn setBackgroundImage:[UIImage imageNamed:@"icon-weixin"] forState:UIControlStateNormal];
//    [wxbtn addTarget:self action:@selector(loginToAppByWX) forControlEvents:UIControlEventTouchUpInside];
//    [thirdloginView addSubview:wxbtn];
//    
//    UIButton *qqbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [qqbtn setBackgroundImage:[UIImage imageNamed:@"icon-qq"] forState:UIControlStateNormal];
//    qqbtn.frame = CGRectMake(thirdloginView.center.x+10, label.bottom, 35, 35);
//    [qqbtn addTarget:self action:@selector(loginToAppByQQ) forControlEvents:UIControlEventTouchUpInside];
//    [thirdloginView addSubview:qqbtn];
    
    
}

-(void)loginByTelNum:(UIButton *)loginBtn
{
    if (self.phoneTf.text.length==0||self.phoneTf.text==nil) {
        [self showAlertViewWithText:@"请输入您的账号" duration:1];
        return;
    }
    if (self.passTf.text.length == 0||self.passTf.text==nil) {
        [self showAlertViewWithText:@"请输入密码" duration:1];
        return;
    }
    [SVProgressHUD showWithStatus:@"正在登录..." maskType:SVProgressHUDMaskTypeClear];
    [JGHTTPClient loginByPhoneNum:self.phoneTf.text passWord:self.passTf.text MD5:YES Success:^(id responseObject) {
        JGLog(@"%@",responseObject);
        [SVProgressHUD dismiss];
        
        if ([responseObject[@"code"] integerValue] == 200) {
            JGUser *user = [JGUser shareUser];
            [JGUser saveUser:user WithDictionary:responseObject];
            [NotificationCenter postNotificationName:kNotificationLoginSuccessed object:nil];
            APPLICATION.keyWindow.rootViewController = [[MyTabBarController alloc] init];
            [CoreLaunchCool animWithWindow:APPLICATION.keyWindow image:[self ShootmeDidSuccessful]];
        }else{
            [self showAlertViewWithText:responseObject[@"message"] duration:1];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self showAlertViewWithText:NETERROETEXT duration:1];
    }];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
#pragma mark 监听 textFIeld 输入
-(void)ensureRightInPut:(UITextField *)textField
{
    if(textField == self.phoneTf){
        if (self.phoneTf.text.length>20) {
            self.phoneTf.text = [self.phoneTf.text substringToIndex:20];
        }
    }else{//密码
        
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


-(void)dealloc
{
    [NotificationCenter removeObserver:self name:kNotificationLoginSuccessed object:nil];
}

@end
