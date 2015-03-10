//
//  Geit_ActivityView.h
//  GeitWorkOrderManager
//
//  Created by 小白 on 13-12-18.
//  Copyright (c) 2013年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface Geit_ActivityView : NSObject
{
     MBProgressHUD *_hud;
     BOOL _flag;
}
//AS_SINGLETON(Geit_ActivityView);

@property (nonatomic,assign) BOOL flag;
+ (Geit_ActivityView *)sharedInstance;
- (void)setupParam;
- (void)showAttention:(id)viewController detail:(NSString *)detail;
- (void)showActivity:(UIView *)view detail:(NSString *)detail;
- (void)hideActivity:(UIView *)view;
- (float)getIphoneHeight;
//根据textfield长度和string的长度得到最适宜的字体大小
- (float)setTextSizeWithTextFieldSize:(CGSize)size StringLength:(NSString *)string;
//根据label长度自动分段，改变字体大小
- (float)setTextSizeWithLabelSize:(CGSize)size StringLength:(NSString *)string;
- (void)setAnimation:(UIView *)view withAnimationType:(NSString *)name withFromDirection:(NSString *)direction;
@end
