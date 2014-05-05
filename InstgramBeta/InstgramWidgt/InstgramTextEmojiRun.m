//
//  InstgramTextEmojiRun.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-29.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramTextEmojiRun.h"

@implementation InstgramTextEmojiRun

- (id)init
{
    if (self = [super init]) {
        self.isResponseTouch = NO;
    }
    
    return self;
}

+ (NSString*)analyseText:(NSString*)text andRunsObjectArray:(NSMutableArray**)runsArray
{
    NSMutableString* newString = [NSMutableString stringWithCapacity:0];
    
    NSMutableArray* emojiArray = [NSMutableArray arrayWithCapacity:0];
    
    int offsetIndex = 0;
    
    //将text中的表情符替换@" "
    for (int i = 0;i < text.length; i ++)
    {
        NSString* character = [text substringWithRange:NSMakeRange(i, 1)];
        
        if ([emojiArray count] > 0)
        {
            if ([character isEqualToString:emojiTextStartMark] && [[emojiArray objectAtIndex:0] isEqualToString:emojiTextStartMark])
            {
                for (NSString* str in emojiArray)
                {
                    [newString appendString:str];
                }
                
                [emojiArray removeAllObjects];
            }
            
            [emojiArray addObject:character];
            
            if ([character isEqualToString:emojiTextEndMark] || i == text.length - 1)
            {
                NSMutableString* emojiString = [NSMutableString stringWithCapacity:0];
                for (NSString* str in emojiArray)
                {
                    [emojiString appendString:str];
                }
                
                if ([[InstgramTextEmojiRun getEmojiArray] containsObject:emojiString])
                {
                    InstgramTextEmojiRun* emojiRun = [[InstgramTextEmojiRun alloc] init];
                    emojiRun.originalText = emojiString;
                    emojiRun.range = NSMakeRange(i - emojiString.length + 1 - offsetIndex, 1);
                    [*runsArray addObject:emojiRun];
                    
                    [newString appendString:@" "];
                    
                    offsetIndex += emojiString.length - 1;
                }
                else{
                    [newString appendString:emojiString];
                }
                
                [emojiArray removeAllObjects];
            }
        }
        else
        {
            if ([character isEqualToString:emojiTextStartMark])
            {
                [emojiArray addObject:character];
            }
            else{
                [newString appendString:character];
            }
        }
    }
    
    return newString;
}

- (void)attributedStringAddAttribute:(NSMutableAttributedString *)attributedString
{
    //删除占位符 @" "
    [attributedString deleteCharactersInRange:self.range];
    
    CTRunDelegateCallbacks emojiCallbacks;
    emojiCallbacks.version      = kCTRunDelegateVersion1;
    emojiCallbacks.dealloc      = InstgramTextRunEmojiDelegateDeallocCallback;
    emojiCallbacks.getAscent    = InstgramTextRunEmojiDelegateGetAscentCallback;
    emojiCallbacks.getDescent   = InstgramTextRunEmojiDelegateGetDescentCallback;
    emojiCallbacks.getWidth     = InstgramTextRunEmojiDelegateGetWidthCallback;
    
    NSMutableAttributedString *imageAttributedString = [[NSMutableAttributedString alloc] initWithString:@" "];
    
    //创建CTRun回调
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&emojiCallbacks, (__bridge void*)self);
    [imageAttributedString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate range:NSMakeRange(0, 1)];
    CFRelease(runDelegate);
    
    // imageAttributedString: CTRunDelegate = "<CTRunDelegate 0x8d300a0 [0x1a01ec8]>
    [attributedString insertAttributedString:imageAttributedString atIndex:self.range.location];

    [super attributedStringAddAttribute:attributedString];
}

/**
 *  callback
 */
void InstgramTextRunEmojiDelegateDeallocCallback(void *refCon)
{
    
}

//--上缘高度
CGFloat InstgramTextRunEmojiDelegateGetAscentCallback(void *refCon)
{
    InstgramTextEmojiRun* emojiRun =(__bridge InstgramTextEmojiRun *) refCon;
    return emojiRun.originalFont.ascender ;
}

//--下缘高度
CGFloat InstgramTextRunEmojiDelegateGetDescentCallback(void *refCon)
{
    InstgramTextEmojiRun* emojiRun =(__bridge InstgramTextEmojiRun *) refCon;
    return emojiRun.originalFont.descender;
}

//-- 高
CGFloat InstgramTextRunEmojiDelegateGetWidthCallback(void *refCon)
{
    InstgramTextEmojiRun* emojiRun =(__bridge InstgramTextEmojiRun *) refCon;
    return (emojiRun.originalFont.ascender - emojiRun.originalFont.descender);
}



- (BOOL)drawRunWithRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSString *emojiString = [NSString stringWithFormat:@"%@.png",self.originalText];
    
    UIImage *image = [UIImage imageNamed:emojiString];
    if (image)
    {
        CGContextDrawImage(context, rect, image.CGImage);
    }
    return  YES;
}

+ (NSArray*)getEmojiArray
{
    return  [NSArray arrayWithObjects:@"[smile]",@"[cry]",nil];
}

@end
