//
//  InstgramLoginViewController.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramLoginViewController.h"
#import "InstgramMainViewController.h"

@interface InstgramLoginViewController ()

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
    [self presentViewController:mainVC animated:YES completion:nil];
}



#pragma mark - Private methods

- (void)setupView
{
    
    
    UIButton* loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setFrame:CGRectMake(0, 0, 100, 60)];
    [loginButton setCenter:self.view.center];
    [loginButton setBackgroundColor:[UIColor orangeColor]];
    [loginButton setTitle:@"登   录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(onLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
}



@end
