//
//  InstgramSetPasswordViewController.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-31.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramSetPasswordViewController.h"
#import "Geit_ActivityView.h"
#import "InstgramAccountActionController.h"
#import "InstgramPerfectUserInfoViewController.h"

@interface InstgramSetPasswordViewController ()<UITextFieldDelegate,InstgramActionAccontDelegate>
{
    UITextField* _passwordTextField;
}

@end

@implementation InstgramSetPasswordViewController

@synthesize phoneNumber;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self.navigationItem setHidesBackButton:YES];
    }
    return self;
}

- (void)dealloc
{
    [[InstgramAccountActionController sharedInstance] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupActionController];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)setupActionController
{
    [[InstgramAccountActionController sharedInstance] addObserver:self];
}

- (void)setupView
{
    [self setNavigationTitle:@"设置密码"];
    [self setCloseBarItem];
    
    UIImageView* passwordBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 55)];
    [passwordBgImageView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
    [passwordBgImageView setImage:[UIImage imageNamed:@"user_login_input"]];
    passwordBgImageView.userInteractionEnabled = YES;
    [self.view addSubview:passwordBgImageView];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, passwordBgImageView.bounds.origin.y, passwordBgImageView.bounds.size.width - 20, passwordBgImageView.bounds.size.height)];
    [_passwordTextField setBorderStyle:UITextBorderStyleNone];
    _passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passwordTextField.placeholder = @"6-16位字母数字下划线";
    [_passwordTextField setSecureTextEntry:YES];
    [_passwordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    _passwordTextField.textAlignment = NSTextAlignmentLeft;
    _passwordTextField.textColor = [UIColor colorWithHex:kFontColorGray];
    _passwordTextField.font = [UIFont fontWithName:kDefaultFontName size:kTextFieldFont];
    _passwordTextField.returnKeyType = UIReturnKeyDefault;
    _passwordTextField.keyboardType = UIKeyboardTypeDefault;
    _passwordTextField.delegate = self;
//    [_passwordTextField addTarget:self action:@selector(onFinishAction:) forControlEvents:UIControlEventEditingDidEndOnExit];
    //set rightView
    [_passwordTextField setRightViewMode:UITextFieldViewModeAlways];
    UISwitch* hideOrShowSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(10, 180, 0, 0)];
    [hideOrShowSwitch setOn:YES];
    [hideOrShowSwitch addTarget:self action:@selector(hideOrShowValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_passwordTextField setRightView:hideOrShowSwitch];
    [passwordBgImageView addSubview:_passwordTextField];
    
    UIButton* finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.frame = CGRectMake(10,passwordBgImageView.frame.origin.y + passwordBgImageView.bounds.size.height + 5,passwordBgImageView.bounds.size.width,40);
    [finishButton setBackgroundImage:[[UIImage imageNamed:@"login_buttonbg_normal"]  stretchImage]forState:UIControlStateNormal];
    [finishButton setBackgroundImage:[[UIImage imageNamed:@"login_buttonbg_highlighted"] stretchImage] forState:UIControlStateHighlighted];
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(onFinishAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishButton];
}

- (void)onFinishAction:(id)sender
{
    
    [_passwordTextField resignFirstResponder];
    //验证密码
    if ([NSString stringIsEmpty:_passwordTextField.text]) {
        [_passwordTextField resignFirstResponder];
        [[Geit_ActivityView sharedInstance] showAttention:self.view detail:@"请输入密码"];
        return;
    }
    
    // #define REGEX_PASSWORD @"^[a-zA-Z0-9_][a-zA-Z0-9_]{5,15}$"
    // 以字母（大小写均可）、数字、下划线开头，6-16位字母数字下划线
    if (![_passwordTextField.text match:REGEX_PASSWORD]) {
        [[Geit_ActivityView sharedInstance] showAttention:self.view detail:@"密码格式不正确"];
        return;
    }
    
    //开始注册
    [[Geit_ActivityView sharedInstance] showActivity:self.view detail:@"开始注册"];
    [[InstgramAccountActionController sharedInstance] instagramRegist:self.phoneNumber password:_passwordTextField.text];
    
    //test
    //跳转完善资料页面
//    InstgramPerfectUserInfoViewController* perfectUserInfoVC = [[InstgramPerfectUserInfoViewController alloc] initWithNibName:nil bundle:nil];
//    [self.navigationController pushViewController:perfectUserInfoVC animated:YES];
}

//值已经改变
- (void)hideOrShowValueChanged:(id)sender
{
    UISwitch* switchController = (UISwitch*)sender;
    BOOL status = switchController.on;
    if (status)
    {
        _passwordTextField.enabled = NO;
        [_passwordTextField setSecureTextEntry:YES];
        _passwordTextField.enabled = YES;

    }
    else
    {
        _passwordTextField.enabled = NO;
        [_passwordTextField setSecureTextEntry:NO];
        _passwordTextField.enabled = YES;

    }
}

#pragma mark - InstgramActionAccontDelegate

//注册成功
- (void)registSucc
{
    [[Geit_ActivityView sharedInstance] hideActivity:self.view];
    [[Geit_ActivityView sharedInstance] showAttention:self.view detail:@"注册成功"];
    //跳转完善资料页面
    InstgramPerfectUserInfoViewController* perfectUserInfoVC = [[InstgramPerfectUserInfoViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:perfectUserInfoVC animated:YES];
}

- (void)registFailed:(NSError *)error
{
    [[Geit_ActivityView sharedInstance] hideActivity:self.view];
    [[Geit_ActivityView sharedInstance] showAttention:self.view detail:error.localizedDescription];
}



@end
