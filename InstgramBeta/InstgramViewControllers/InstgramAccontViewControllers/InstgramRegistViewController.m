//
//  InstgramRegistViewController.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-30.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramRegistViewController.h"
#import "PooCodeView.h"
#import "Geit_ActivityView.h"
#import "InstgramInputCodeViewController.h"


@interface InstgramRegistViewController ()<UITextFieldDelegate>
{
    UITextField* _phoneNumberTextField;
    UITextField* _identiferCodeTextField;
    PooCodeView* _identifyCodeView;
}

@end

@implementation InstgramRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)setupView
{
    [self setNavigationTitle:@"注册"];
    [self setBackBarItem];
    
    UIImageView* phoneNumBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 55)];
    [phoneNumBgImageView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
    [phoneNumBgImageView setImage:[UIImage imageNamed:@"user_login_input"]];
    phoneNumBgImageView.userInteractionEnabled = YES;
    [self.view addSubview:phoneNumBgImageView];
    
    _phoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, phoneNumBgImageView.bounds.origin.y, phoneNumBgImageView.bounds.size.width - 20, phoneNumBgImageView.bounds.size.height)];
    [_phoneNumberTextField setBorderStyle:UITextBorderStyleNone];
    _phoneNumberTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneNumberTextField.placeholder = @"请输入手机号";
    [_phoneNumberTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    _phoneNumberTextField.textAlignment = NSTextAlignmentLeft;
    _phoneNumberTextField.textColor = [UIColor colorWithHex:kFontColorGray];
    _phoneNumberTextField.font = [UIFont fontWithName:kDefaultFontName size:kTextFieldFont];
    _phoneNumberTextField.returnKeyType = UIReturnKeyNext;
    _phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumberTextField.delegate = self;
//    [_phoneNumberTextField addTarget:self action:@selector(onNextAction:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [phoneNumBgImageView addSubview:_phoneNumberTextField];
    
    UIImageView* codeBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, phoneNumBgImageView.frame.origin.y + phoneNumBgImageView.bounds.size.height + 5 , 200, 55)];
    [codeBgImageView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
    [codeBgImageView setImage:[UIImage imageNamed:@"user_login_input"]];
    codeBgImageView.userInteractionEnabled = YES;
    [self.view addSubview:codeBgImageView];
    
    _identiferCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(codeBgImageView.bounds.origin.x + 10, codeBgImageView.bounds.origin.y, codeBgImageView.bounds.size.width - 20, codeBgImageView.bounds.size.height)];
    [_identiferCodeTextField setBorderStyle:UITextBorderStyleNone];
    _identiferCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _identiferCodeTextField.placeholder = @"请输入验证码";
    [_identiferCodeTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_identiferCodeTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    _identiferCodeTextField.textAlignment = NSTextAlignmentLeft;
    _identiferCodeTextField.textColor = [UIColor colorWithHex:kFontColorGray];
    _identiferCodeTextField.font = [UIFont fontWithName:kDefaultFontName size:kTextFieldFont];
    _identiferCodeTextField.returnKeyType = UIReturnKeyNext;
    _identiferCodeTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    _identiferCodeTextField.delegate = self;
    [_identiferCodeTextField addTarget:self action:@selector(onGetCodeAction:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [codeBgImageView addSubview:_identiferCodeTextField];
    
    _identifyCodeView = [[PooCodeView alloc] initWithFrame:CGRectMake(codeBgImageView.frame.origin.x + codeBgImageView.bounds.size.width + 5, phoneNumBgImageView.frame.origin.y + phoneNumBgImageView.bounds.size.height + 5 + 5, phoneNumBgImageView.bounds.size.width - codeBgImageView.frame.origin.x - codeBgImageView.bounds.size.width , codeBgImageView.bounds.size.height - 5 - 5)];
    [self.view addSubview:_identifyCodeView];
    
    UIButton* getCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getCodeButton.frame = CGRectMake(10,codeBgImageView.frame.origin.y + codeBgImageView.bounds.size.height + 5,phoneNumBgImageView.bounds.size.width,40);
    [getCodeButton setBackgroundImage:[[UIImage imageNamed:@"login_buttonbg_normal"]  stretchImage]forState:UIControlStateNormal];
    [getCodeButton setBackgroundImage:[[UIImage imageNamed:@"login_buttonbg_highlighted"] stretchImage] forState:UIControlStateHighlighted];
    [getCodeButton setTitle:@"获取短信验证码" forState:UIControlStateNormal];
    [getCodeButton addTarget:self action:@selector(onGetCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getCodeButton];
}

#pragma mark - Button Methods

- (void)onGetCodeAction:(id)sender
{
//    //参数判断
//    if ([NSString stringIsEmpty:_phoneNumberTextField.text] || [NSString stringIsEmpty:_identiferCodeTextField.text]) {
//        [_phoneNumberTextField resignFirstResponder];
//        [_identiferCodeTextField resignFirstResponder];
//        [[Geit_ActivityView sharedInstance] showAttention:self.view detail:@"手机号和验证码不能为空"];
//        return;
//    }
//    
//    //判断手机号
//    if (![_phoneNumberTextField.text match:REGEX_PHONENO]) {
//        [_phoneNumberTextField resignFirstResponder];
//        [_identiferCodeTextField resignFirstResponder];
//        [[Geit_ActivityView sharedInstance] showAttention:self.view detail:@"手机号格式不正确"];
//        return;
//    }
//    
//    //判断验证码
//    if (![_identiferCodeTextField.text compareToStringCaseInsensitive:_identifyCodeView.changeString]) {
//        [_phoneNumberTextField resignFirstResponder];
//        [_identiferCodeTextField resignFirstResponder];
//        [[Geit_ActivityView sharedInstance] showAttention:self.view detail:@"验证码不正确"];
//        return;
//    }
    
    InstgramInputCodeViewController* inputCodeVC = [[InstgramInputCodeViewController alloc] initWithNibName:nil bundle:nil];
    inputCodeVC.phoneNumber = _phoneNumberTextField.text;
    [self.navigationController pushViewController:inputCodeVC animated:YES];
}



@end
