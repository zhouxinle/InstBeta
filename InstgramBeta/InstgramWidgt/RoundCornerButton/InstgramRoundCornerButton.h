//
//  InstgramRoundCornerButton.h
//  InstgramBeta
//
//  Created by zhouxinle on 15-1-13.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	@brief	圆角按钮半径
 */
typedef NS_ENUM(NSUInteger, InstagramAvatarButtonRadius) {
    InstagramAvatarButtonRadius12          = 12,
    InstagramAvatarButtonRadius15          = 15,
    InstagramAvatarButtonRadius17          = 17,
    InstagramAvatarButtonRadius20          = 20,
    InstagramAvatarButtonRadius25          = 25,
    InstagramAvatarButtonRadius30          = 30,
};

/**
 *	@brief	第三方账户下标表示
 */
typedef NS_ENUM(NSUInteger, InstagramAvatarButtonSnsType) {
    InstagramAvatarButtonSnsTypeNone          = 0,    // 不显示
    InstagramAvatarButtonSnsTypeQQ            = 1,    // QQ
    InstagramAvatarButtonSnsTypeSina          = 2,    // 新浪微博
    InstagramAvatarButtonSnsTypeWeixin        = 3,    // 微信（预留）
};

@interface InstgramRoundCornerButton : UIButton

/**
 *  @brief  初始化头像View
 *  @param  point                   位置
 *  @param  badge                   badge为nil或空字符串时候不显示
 *  @param  url                     头像URL
 *  @param  avatarButtonSnsType     右下脚标识
 *  @param  radius                  头像半径
 *  @return CTBAvatarView
 */
- (id)initWithPoint:(CGPoint)centerPoint badge:(NSString *)badge avatarButtonSnsType:(InstagramAvatarButtonSnsType)snsType Radius:(InstagramAvatarButtonRadius)radius;

-(void)setImageWithData:(NSData *)data;

@end
