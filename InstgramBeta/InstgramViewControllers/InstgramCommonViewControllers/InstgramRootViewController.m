//
//  InstgramRootViewController.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramRootViewController.h"

@interface InstgramRootViewController ()

@end

@implementation InstgramRootViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public Methods

- (void)setNavigationTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 160, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.navigationItem setTitleView:titleLabel];
}

@end
