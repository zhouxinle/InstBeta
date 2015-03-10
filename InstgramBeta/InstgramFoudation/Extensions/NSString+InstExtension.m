//
//  NSString+InstExtension.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-30.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "NSString+InstExtension.h"

@implementation NSString (InstExtension)


- (BOOL)match:(NSString *)expression
{
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    if ( nil == regex )
        return NO;
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self
                                                        options:0
                                                          range:NSMakeRange(0, self.length)];
    if ( 0 == numberOfMatches )
        return NO;
    
    return YES;
}

+ (BOOL)stringIsEmpty:(NSString*)aString
{
    if ([aString isKindOfClass:[NSNumber class]]) {
        return YES;
    }
    
    if ((NSNull *)aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if (![aString isKindOfClass:[NSString class]]) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)stringIsNoEmpty:(NSString*)aString;
{
    return ![self stringIsEmpty:aString];
}

//不区分大小写比较字符串
- (BOOL)compareToStringCaseInsensitive:(NSString*)string
{
    if ([self compare:string options:NSCaseInsensitiveSearch] != NSOrderedSame) {
        return NO;
    }
    
    return YES;
}

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
- (CGSize)sizeWithFont:(UIFont *)font byWidth:(CGFloat)width
{
    return [self sizeWithFont:font
            constrainedToSize:CGSizeMake(width, 999999.0f)
                lineBreakMode:NSLineBreakByWordWrapping];
}

- (CGSize)sizeWithFont:(UIFont *)font byHeight:(CGFloat)height
{
    return [self sizeWithFont:font
            constrainedToSize:CGSizeMake(999999.0f, height)
                lineBreakMode:NSLineBreakByWordWrapping];
}
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)


@end
