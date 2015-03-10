//
//  UIColor+CTBExtension.h
//  autopia
//
//  Created by sun on 13-6-9.
//  Copyright (c) 2013年 www.chetuobang.com . All rights reserved.
//

#import <UIKit/UIKit.h>


#define UIColorFromRGB(rgbValue)        [UIColor             \
colorWithRed: ((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green: ((float)((rgbValue & 0xFF00) >> 8)) / 255.0           \
blue: ((float)(rgbValue & 0xFF)) / 255.0 alpha : 1.0]

#define UIColorFromRGBValue(r, g, b)    [UIColor \
colorWithRed : ((float)(r)) / 255.0      \
green : ((float)(g)) / 255.0             \
blue : ((float)(b)) / 255.0 alpha : 1.0]

@interface UIColor (CTBExtension)

+ (UIColor *) colorWithHexString:(NSString *)stringToConvert;

+ (id) colorWithHex:(unsigned int)hex;
+ (id) colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha;

+ (id) randomColor;

@end
