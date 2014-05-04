//
//  UINavigationController+InstgramNavigationController.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "UINavigationController+InstgramNavigationController.h"
#import "InstgramFoudation.h"

@implementation UINavigationController (InstgramNavigationController)

- (id)initWithRootViewController:(UIViewController *)rootViewController withCustomNavBar:(UINavigationBar *)navBar
{
    self = [self initWithRootViewController:rootViewController];
    if (self) {
        [self setValue:navBar forKey:@"navigationBar"];
        // [self.navigationBar setTintColor:[UIColor orangeColor]];
        if (IOS7_OR_LATER)
        {
            //ios7下，导航栏自定义图片背景，高64，连带着这是了statusBar的背景
            [[CustomNavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bar_bg_ios7"] forBarMetrics:UIBarMetricsDefault];
        }
        else{
            //ios7一下只要设置44高的导航栏背景图片
            [[CustomNavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bar_bg"] forBarMetrics:UIBarMetricsDefault];
        }
    }
    return self;
}

@end


@implementation CustomNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// 调整NavigationItem位置
- (void)layoutSubviews
{
    [super layoutSubviews];

}


@end
