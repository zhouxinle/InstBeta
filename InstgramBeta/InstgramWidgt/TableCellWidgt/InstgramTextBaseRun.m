//
//  InstgramTextBaseRun.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-29.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramTextBaseRun.h"

@implementation InstgramTextBaseRun

@synthesize originalText = _originalText;
@synthesize originalFont = _originalFont;
@synthesize range = _range;
@synthesize isResponseTouch = _isResponseTouch;

- (id)init
{
    if (self = [super init])
    {
        self.isResponseTouch = NO;
    }
    
    return self;
}


/**
 *  绘制run
 *
 *  @param rect rect
 *
 *  @return YES:自己绘制 NO:coretext绘制
 */
- (BOOL)drawRunWithRect:(CGRect)rect
{
    return NO;
}

/**
 *  设置当前run的key
 *
 *  @param attributedString
 */
- (void)attributedStringAddAttribute:(NSMutableAttributedString*)attributedString
{
    [attributedString addAttribute:@"RunType" value:self range:self.range];
}


@end
