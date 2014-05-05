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
 *  识别出text中的url url替换成@" "
 *
 *  @param text      文本
 *  @param runsArray
 *
 *  @return
 */
+ (NSString*)analyseText:(NSString*)text andRunsObjectArray:(NSMutableArray**)runsArray
{
    
    NSMutableString* newString = [NSMutableString stringWithString:text];
    
    NSError *error;

    //正则表达式
    NSString *regulaStr = @"(https?|ftp|file)://[-A-Z0-9+&#/%?=~_|!:,.;]*[-A-Z0-9+&#/%=~_|]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:newString options:0 range:NSMakeRange(0, [newString length])];

    int offset = 0;
    
    for (NSTextCheckingResult* match in arrayOfAllMatches)
    {
        NSRange range = NSMakeRange(match.range.location - offset, match.range.length);
        NSString* matchString = [newString substringWithRange:range];
        //url run对象
        InstgramTextUrlRun* urlRun = [[InstgramTextUrlRun alloc] init];
        urlRun.originalText = matchString;
        [newString replaceCharactersInRange:range withString:@" "];
        NSRange urlRange = NSMakeRange(range.location, 1);
        urlRun.range = urlRange;
        offset = match.range.length - 1;
        
        [*runsArray addObject:urlRun];
    }

    return newString;
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
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSString *urlImageString = @"link.png";
    
    UIImage *image = [UIImage imageNamed:urlImageString];
    if (image)
    {
        CGContextDrawImage(context, rect, image.CGImage);
    }
    return  YES;
}

- (void)attributedStringAddAttribute:(NSMutableAttributedString *)attributedString
{
    //删除占位符 @" "
    [attributedString deleteCharactersInRange:self.range];
    
    CTRunDelegateCallbacks urlCallbacks;
    urlCallbacks.version      = kCTRunDelegateVersion1;
    urlCallbacks.dealloc      = InstgramTextRunUrlDelegateDeallocCallback;
    urlCallbacks.getAscent    = InstgramTextRunUrlDelegateGetAscentCallback;
    urlCallbacks.getDescent   = InstgramTextRunUrlDelegateGetDescentCallback;
    urlCallbacks.getWidth     = InstgramTextRunUrlDelegateGetWidthCallback;
    
    NSMutableAttributedString *imageAttributedString = [[NSMutableAttributedString alloc] initWithString:@" "];
    
    //创建CTRun回调
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&urlCallbacks, (__bridge void*)self);
    [imageAttributedString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate range:NSMakeRange(0, 1)];
    CFRelease(runDelegate);
    
    // imageAttributedString: CTRunDelegate = "<CTRunDelegate 0x8d300a0 [0x1a01ec8]>
    [attributedString insertAttributedString:imageAttributedString atIndex:self.range.location];
    
    [super attributedStringAddAttribute:attributedString];
}

/**
 *  callback
 */
void InstgramTextRunUrlDelegateDeallocCallback(void *refCon)
{
    
}

//--上缘高度
CGFloat InstgramTextRunUrlDelegateGetAscentCallback(void *refCon)
{
    InstgramTextUrlRun* urlRun =(__bridge InstgramTextUrlRun *) refCon;
    return urlRun.originalFont.ascender ;
}

//--下缘高度
CGFloat InstgramTextRunUrlDelegateGetDescentCallback(void *refCon)
{
    InstgramTextUrlRun* urlRun =(__bridge InstgramTextUrlRun *) refCon;
    return urlRun.originalFont.descender;
}

//-- 宽
CGFloat InstgramTextRunUrlDelegateGetWidthCallback(void *refCon)
{
    return 50;
//    InstgramTextEmojiRun* emojiRun =(__bridge InstgramTextEmojiRun *) refCon;
//    return (emojiRun.originalFont.ascender - emojiRun.originalFont.descender);
}



@end
