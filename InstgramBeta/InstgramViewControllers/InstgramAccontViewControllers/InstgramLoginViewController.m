//
//  InstgramLoginViewController.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramLoginViewController.h"
#import "InstgramMainViewController.h"

@interface InstgramLoginViewController ()<UITextFieldDelegate>
{
    UITextField* _usernameTextFiled;
    UITextField* _passwordTextField;
}

@end

@implementation InstgramLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button methods

- (void)onLoginAction:(id)sender
{
    InstgramMainViewController* mainVC = [[InstgramMainViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:mainVC animated:NO completion:nil];
}



#pragma mark - Private methods

- (void)setupView
{
    [self setNavigationTitle:@"登录"];
    [self setBackBarItem];
    
    //账号
    UIImageView* usernameBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 55)];
    [usernameBgImageView setImage:[UIImage imageNamed:@"user_login_input"]];
    [self.view addSubview:usernameBgImageView];
    usernameBgImageView.userInteractionEnabled = YES;
    
    UIImageView* profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 25, 25)];
    profileImageView.image = [UIImage imageNamed:@"username_left"];
    [usernameBgImageView addSubview:profileImageView];
    [usernameBgImageView drawRectWithViewRect:CGRectMake(45, 10, 1, 35) color:[UIColor colorWithHex:0xe5e5e5]];
    
    _usernameTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(55,0,230,55)];
    [_usernameTextFiled setBorderStyle:UITextBorderStyleNone];
    _usernameTextFiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _usernameTextFiled.placeholder = @"手机号/自有账号";
    [_usernameTextFiled setClearButtonMode:UITextFieldViewModeWhileEditing];
    _usernameTextFiled.textAlignment = NSTextAlignmentLeft;
    _usernameTextFiled.textColor = [UIColor colorWithHex:kFontColorGray];
    _usernameTextFiled.font = [UIFont fontWithName:kDefaultFontName size:kTextFieldFont];
    _usernameTextFiled.returnKeyType = UIReturnKeyNext;
    _usernameTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
    _usernameTextFiled.delegate = self;
    [_usernameTextFiled addTarget:self action:@selector(onNextAction:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [usernameBgImageView addSubview:_usernameTextFiled];
    
    //password
    UIImageView* passwdBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, usernameBgImageView.frame.origin.y+usernameBgImageView.bounds.size.height+5,300, 55)];
    [passwdBgImageView setImage:[UIImage imageNamed:@"user_login_input"]];
    [self.view addSubview:usernameBgImageView];
    
    UIImageView* lockImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 25, 25)];
    lockImageView.image = [UIImage imageNamed:@"password_lock"];
    [passwdBgImageView addSubview:lockImageView];
    [passwdBgImageView drawRectWithViewRect:CGRectMake(45, 10, 1, 35) color:[UIColor colorWithHex:0xe5e5e5]];
    passwdBgImageView.userInteractionEnabled = YES;
    [self.view addSubview:passwdBgImageView];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(55,0,190,55)];
    [_passwordTextField setBorderStyle:UITextBorderStyleNone];
    _passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passwordTextField.placeholder = @"密码";
    
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.clearsOnBeginEditing = YES;
    _passwordTextField.returnKeyType = UIReturnKeyDone;
    _passwordTextField.font = [UIFont fontWithName:kDefaultFontName size:kTextFieldFont];
    _passwordTextField.delegate = self;
    [_passwordTextField addTarget:self action:@selector(onLoginAction:) forControlEvents:UIControlEventEditingDidEndOnExit];
    //    [passwordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    _passwordTextField.textColor = [UIColor colorWithHex:kFontColorGray];
    _passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [passwdBgImageView addSubview:_passwordTextField];
    
}




@end
