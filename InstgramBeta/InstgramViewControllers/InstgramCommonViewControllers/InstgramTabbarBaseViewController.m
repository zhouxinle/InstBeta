//
//  InstgramTabbarBaseViewController.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramTabbarBaseViewController.h"
#import "InstgramNearByViewController.h"
#import "InstgramRelatedViewController.h"
#import "InstgramPersonalViewController.h"
#import "InstgramTakePhotoViewController.h"
#import "InstgramHotRankViewController.h"
#import "UINavigationController+InstgramNavigationController.h"

@interface InstgramTabbarBaseViewController ()

@end

@implementation InstgramTabbarBaseViewController

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

#pragma mark - Button Methods

- (void)onTakePhotoAction:(id)sender
{
    [self setSelectedIndex:2];
}

#pragma mark - Public Methods

- (UINavigationController*)createViewCtroller:(VCName)vcname
{
    switch (vcname)
    {
        case NearByVC:
        {
            InstgramNearByViewController* nearByVC = [[InstgramNearByViewController alloc] initWithNibName:nil bundle:nil];
            CustomNavigationBar* customBar = [[CustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            UINavigationController* nearByNav = [[UINavigationController alloc] initWithRootViewController:nearByVC withCustomNavBar:customBar];
            [nearByNav setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"附近" image:[UIImage imageNamed:@"nearBy"] tag:0]];
            return nearByNav;
            break;
        }
        case HotRankVC:
        {
            InstgramHotRankViewController* hotRankVC = [[InstgramHotRankViewController alloc] initWithNibName:nil bundle:nil];
            CustomNavigationBar* customBar = [[CustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            UINavigationController* hotRankNav = [[UINavigationController alloc] initWithRootViewController:hotRankVC withCustomNavBar:customBar];
            [hotRankNav setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"热门" image:[UIImage imageNamed:@"hotRank"] tag:0]];
            return hotRankNav;
            break;
        }
        case TakePhotoVC:
        {
            InstgramTakePhotoViewController* takePhotoVC = [[InstgramTakePhotoViewController alloc] initWithNibName:nil bundle:nil];
            CustomNavigationBar* customBar = [[CustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            UINavigationController* takePhotoNav = [[UINavigationController alloc] initWithRootViewController:takePhotoVC withCustomNavBar:customBar];
            [takePhotoNav setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"拍照" image:nil tag:0]];
            return takePhotoNav;
            break;
        }
        case RelatedVC:
        {
            InstgramRelatedViewController* relatedVC = [[InstgramRelatedViewController alloc] initWithNibName:nil bundle:nil];
            CustomNavigationBar* customBar = [[CustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            UINavigationController* relatedNav = [[UINavigationController alloc] initWithRootViewController:relatedVC withCustomNavBar:customBar];
            [relatedNav setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"相关" image:[UIImage imageNamed:@"related"] tag:0]];
            return relatedNav;
            break;
        }
        case PersonalVC:
        {
            InstgramPersonalViewController* personalVC = [[InstgramPersonalViewController alloc] initWithNibName:nil bundle:nil];
            CustomNavigationBar* customBar = [[CustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            UINavigationController* personalNav = [[UINavigationController alloc] initWithRootViewController:personalVC withCustomNavBar:customBar];
            [personalNav setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"个人" image:[UIImage imageNamed:@"personal"] tag:0]];
            return personalNav;
            break;
        }
        default:
            break;
    }
    
    return nil;
}

- (void)setTabbarCenterButton
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    UIImage* buttonImage = [UIImage imageNamed:@"takePhoto"];
    UIImage* highlightImage = nil;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
        button.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        button.center = center;
    }
    [button addTarget:self action:@selector(onTakePhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

@end
