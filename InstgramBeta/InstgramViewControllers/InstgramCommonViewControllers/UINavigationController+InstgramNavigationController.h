//
//  UINavigationController+InstgramNavigationController.h
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationBar : UINavigationBar

@end

@interface UINavigationController (InstgramNavigationController)

- (id)initWithRootViewController:(UIViewController *)rootViewController withCustomNavBar:(UINavigationBar*)navBar;

@end
