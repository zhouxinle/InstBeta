//
//  InstgramSetNickNameViewController.m
//  InstgramBeta
//
//  Created by zhouxinle on 15-1-15.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "InstgramSetNickNameViewController.h"
#import "InstgramAccountActionController.h"

@interface InstgramSetNickNameViewController ()<UITextFieldDelegate>
{
    UITextField* _nicknameTextField;
}

@end

@implementation InstgramSetNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupController];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)setupController
{
    [[InstgramAccountActionController sharedInstance] addObserver:self];
}

- (void)setupView
{
    [self setNavigationTitle:@"设置昵称"];
    [self setBackBarItem];
    [self setSaveBarItem];
    
    UIImageView* nickNameBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 55)];
    [nickNameBgImageView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
    [nickNameBgImageView setImage:[UIImage imageNamed:@"user_login_input"]];
    nickNameBgImageView.userInteractionEnabled = YES;
    [self.view addSubview:nickNameBgImageView];
    
    _nicknameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, nickNameBgImageView.bounds.origin.y, nickNameBgImageView.bounds.size.width - 20, nickNameBgImageView.bounds.size.height)];
    [_nicknameTextField setBorderStyle:UITextBorderStyleNone];
    _nicknameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _nicknameTextField.placeholder = @"2-10位汉字字母数字组合";
    [_nicknameTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_nicknameTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    _nicknameTextField.textAlignment = NSTextAlignmentLeft;
    _nicknameTextField.textColor = [UIColor colorWithHex:kFontColorGray];
    _nicknameTextField.font = [UIFont fontWithName:kDefaultFontName size:kTextFieldFont];
    _nicknameTextField.returnKeyType = UIReturnKeyDefault;
    _nicknameTextField.keyboardType = UIKeyboardTypeDefault;
    _nicknameTextField.delegate = self;
    //    [_phoneNumberTextField addTarget:self action:@selector(onNextAction:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [nickNameBgImageView addSubview:_nicknameTextField];
}

#pragma mark - Button Methods

- (void)onSaveAction:(id)sender
{
    if ([NSString stringIsEmpty:_nicknameTextField.text])
    {
        //用户名不能为空
    }else{
        if (![_nicknameTextField.text match:REGEX_USERNAME]) {
            //用户格式不正确
            NSLog(@"error!!!");
        }else{
            NSLog(@"correct!!!");
            [[InstgramAccountActionController sharedInstance] instagramPerfectUserInfo:nil nickName:_nicknameTextField.text];
        }
    }
    
}


@end
