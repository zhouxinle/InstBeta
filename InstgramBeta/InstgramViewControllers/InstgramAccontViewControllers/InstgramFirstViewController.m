//
//  InstgramFirstViewController.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-29.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramFirstViewController.h"
#import "InstgramLoginViewController.h"
#import "InstgramRegistViewController.h"


@interface InstgramFirstViewController ()


@end

@implementation InstgramFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {

    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)setupView
{
    UIButton* registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registButton.frame = CGRectMake(17,self.view.bounds.size.height - 80, 135, 40);
    [registButton setBackgroundImage:[[UIImage imageNamed:@"user_login_gray"] stretchImage] forState:UIControlStateNormal];
    [registButton setBackgroundImage:[[UIImage imageNamed:@"user_login_hlight"] stretchImage]  forState:UIControlStateHighlighted];
    [registButton setTitle:@"注册" forState:UIControlStateNormal];
    [registButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registButton addTarget:self action:@selector(onRegistAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registButton];
    
    UIButton* loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(170,self.view.bounds.size.height - 80,135,40);
    [loginButton setBackgroundImage:[[UIImage imageNamed:@"login_buttonbg_normal"]  stretchImage]forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[[UIImage imageNamed:@"login_buttonbg_highlighted"] stretchImage] forState:UIControlStateHighlighted];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(onLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

#pragma mark - Button Methods

- (void)onRegistAction:(id)sender
{
    InstgramRegistViewController* registVC = [[InstgramRegistViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:registVC animated:YES];
}

- (void)onLoginAction:(id)sender
{
    InstgramLoginViewController* loginVC = [[InstgramLoginViewController alloc] initWithNibName:nil bundle:nil];

    [self.navigationController pushViewController:loginVC animated:YES];
}

@end
