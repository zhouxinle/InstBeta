//
//  NSString+InstExtension.h
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-30.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -

typedef NSString *(^NSStringAppendBlock)(id format, ...);

#pragma mark -

//#define REGEX_PASSWORD_VALID    (@"^[a-zA-Z0-9_]+$")    // 密码验证
#define REGEX_EMAIL_VALID       (@"^[A-Z0-9a-z._%+-\u4e00-\u9fa5]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$")                      // 用户名验证
//a）	电信：开头数字 133、153、180、181、189
//b）	联通：开头数字 130、131、132、145、155、156、185、186
//c）	移动：开头数字 134、135、136、137、138、139、147、150、151、152、157、158、159、182、183、184、187、188
//#define REGEX_PHONENO                 @"^(1(([35][0-9])|(47)|[8][0123456789]))[0-9]{8}$"
#define REGEX_PHONENO     @"^(1(3[0-9])|(14[579])|(15[0-9])|(18[0-9]))[0-9]{8}$"
#define VERIFYCODE  @"^[0-9]{6}$"
#define REGEX_BANGYOU @"^[a-zA-Z][a-zA-Z0-9_-]{5,19}$"
//用户名正则 中文、大小写字母和数字，{2，10}字符的长度为2-10
#define REGEX_USERNAME @"^[\\u4E00-\\u9FA5\\uF900-\\uFA2D\\w]{2,10}$"
//密码正则
#define REGEX_PASSWORD @"^[a-zA-Z0-9_][a-zA-Z0-9_]{5,15}$"

@interface NSString (InstExtension)

@property(nonatomic, readonly) NSStringAppendBlock APPEND;

@property(nonatomic, readonly) NSData *data;
@property(nonatomic, readonly) NSDate *date;

@property(nonatomic, readonly) NSString *MD5;
@property(nonatomic, readonly) NSData *MD5Data;

// thanks to @uxyheaven
@property(nonatomic, readonly) NSString *SHA1;

- (NSArray *)allURLs;

- (NSDate *)dateFromTimeInterval;

- (NSString *)urlByAppendingDict:(NSDictionary *)params;

- (NSString *)urlByAppendingArray:(NSArray *)params;

- (NSString *)urlByAppendingKeyValues:(id)first, ...;

+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict;

+ (NSString *)queryStringFromArray:(NSArray *)array;

+ (NSString *)queryStringFromKeyValues:(id)first, ...;

+ (BOOL)stringIsEmpty:(NSString *)aString;

+ (BOOL)stringIsNoEmpty:(NSString *)aString;

- (NSString *)URLEncoding;

- (NSString *)URLDecoding;

- (NSString *)trim;

- (NSString *)unwrap;

- (BOOL)match:(NSString *)expression;

- (BOOL)empty;

- (BOOL)notEmpty;

- (BOOL)is:(NSString *)other;

- (BOOL)isNot:(NSString *)other;

- (BOOL)isValueOf:(NSArray *)array;

- (BOOL)isValueOf:(NSArray *)array caseInsens:(BOOL)caseInsens;
//不区分大小写比较字符串
- (BOOL)compareToStringCaseInsensitive:(NSString*)string;

// 计算字符串的字符数，汉字算两个字节。
- (NSInteger)charactersOfString;

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

- (CGSize)sizeWithFont:(UIFont *)font byWidth:(CGFloat)width;

- (CGSize)sizeWithFont:(UIFont *)font byHeight:(CGFloat)height;

#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

+ (BOOL)isAllNum:(NSString *)string;  //判断字符串是否是全数字，是返回yes

@end
