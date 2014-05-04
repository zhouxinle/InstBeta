//
//  InstgramMainViewController.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramMainViewController.h"

@interface InstgramMainViewController ()

@end

@implementation InstgramMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarBackgroud"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupViewControllers];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)setupViewControllers
{
    self.viewControllers = [NSArray arrayWithObjects:[self createViewCtroller:NearByVC],[self createViewCtroller:HotRankVC],[self createViewCtroller:TakePhotoVC],[self createViewCtroller:RelatedVC],[self createViewCtroller:PersonalVC], nil];
    [self setTabbarCenterButton];
    
}

@end
