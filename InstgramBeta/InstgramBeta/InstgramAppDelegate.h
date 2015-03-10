//
//  InstgramAppDelegate.h
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-23.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstgramFirstViewController.h"

@interface InstgramAppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController* nav;
@property (strong, nonatomic) InstgramFirstViewController* firstVC;

@end
