//
//  InstgramTextUrlRun.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-29.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramTextUrlRun.h"

@implementation InstgramTextUrlRun

- (id)init
{
    if (self = [super init]) {
        //响应touch事件
        self.isResponseTouch = YES;
    }
    
    return  self;
}

/**
 *  识别出text中的url
 *
 *  @param text      文本
 *  @param runsArray
 *
 *  @return
 */
+ (NSString*)analyseText:(NSString*)text andRunsObjectArray:(NSMutableArray**)runsArray
{
    NSError *error;

    //正则表达式
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:text options:0 range:NSMakeRange(0, [text length])];
    
    for (NSTextCheckingResult* match in arrayOfAllMatches)
    {
        NSString* matchString = [text substringWithRange:match.range];
        //url run对象
        InstgramTextUrlRun* urlRun = [[InstgramTextUrlRun alloc] init];
        urlRun.originalText = matchString;
        urlRun.range = match.range;
        
        [*runsArray addObject:urlRun];
    }

    return text;
}

/**
 *  url不需要单独绘制
 *
 *  @param rect
 *
 *  @return
 */
- (BOOL)drawRunWithRect:(CGRect)rect
{
    return NO;
}

- (void)attributedStringAddAttribute:(NSMutableAttributedString *)attributedString
{
    //设置url文本显示的颜色
    [attributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[UIColor blueColor].CGColor range:self.range];
    [super attributedStringAddAttribute:attributedString];

}

@end
