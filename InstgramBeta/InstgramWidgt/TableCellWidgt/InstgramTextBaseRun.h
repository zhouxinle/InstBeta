//
//  InstgramTextBaseRun.h
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-29.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface InstgramTextBaseRun : NSObject

/**
 *  原始文本
 *
 *  @param nonatomic
 *  @param assign
 *
 *  @return
 */
@property (nonatomic, copy) NSString* originalText;


/**
 *  字体
 *
 *  @param nonatomic
 *  @param assign
 *
 */
@property (nonatomic, assign) UIFont* originalFont;

/**
 *  文本位置
 */
@property (nonatomic, assign) NSRange range;

/**
 *  是否响应touch事件
 */
@property (nonatomic, assign) BOOL isResponseTouch;

/**
 *  绘制run
 *
 *  @param rect rect
 *
 *  @return YES:自己绘制 NO:coretext绘制
 */
- (BOOL)drawRunWithRect:(CGRect)rect;

/**
 *  设置当前run的key
 *
 *  @param attributedString
 */
- (void)attributedStringAddAttribute:(NSMutableAttributedString*)attributedString;



@end
