//
//  InstgramTextAtRun.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-29.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramTextAtRun.h"

@implementation InstgramTextAtRun

+ (NSString*)analyseText:(NSString*)text andRunsObjectArray:(NSMutableArray**)runsArray
{
    NSError *error;
    
    //正则表达式
    NSString *regulaStr = @"(@[\u4e00-\u9fa5a-zA-Z0-9_]+)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:text options:0 range:NSMakeRange(0, [text length])];
    
    for (NSTextCheckingResult* match in arrayOfAllMatches)
    {
        NSString* matchString = [text substringWithRange:match.range];
        //url run对象
        InstgramTextAtRun* urlRun = [[InstgramTextAtRun alloc] init];
        urlRun.originalText = matchString;
        urlRun.range = match.range;
        
        [*runsArray addObject:urlRun];
    }
    
    return text;
}

- (BOOL)drawRunWithRect:(CGRect)rect
{
    return NO;
}

- (void)attributedStringAddAttribute:(NSMutableAttributedString *)attributedString
{
    //设置url文本显示的颜色
    [attributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[UIColor redColor].CGColor range:self.range];
    [super attributedStringAddAttribute:attributedString];

}

@end
