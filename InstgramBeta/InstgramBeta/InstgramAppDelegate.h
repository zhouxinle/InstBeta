//
//  InstgramAppDelegate.h
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-23.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstgramLoginViewController.h"

@interface InstgramAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) InstgramLoginViewController* loginVC;

@end
