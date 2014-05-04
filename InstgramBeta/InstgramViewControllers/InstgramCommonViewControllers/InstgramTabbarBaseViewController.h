//
//  InstgramTabbarBaseViewController.h
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Enums

typedef NS_ENUM(NSInteger, VCName)
{
    NearByVC                =  0,
    HotRankVC               =  1,
    TakePhotoVC             =  2,
    RelatedVC               =  3,
    PersonalVC              =  4,
};

@interface InstgramTabbarBaseViewController : UITabBarController

- (UINavigationController*)createViewCtroller:(VCName)vcname;

- (void)setTabbarCenterButton;

@end
