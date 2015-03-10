//
//  RequestParam.h
//  GeitWorkOrderManager
//
//  Created by zhouxinle on 13-12-13.
//  Copyright (c) 2013年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestParam : NSObject

@property (nonatomic, copy) NSString* requestUrl;        //请求链接
@property (nonatomic, copy) NSString* callBackPrefix;    //回调函数前缀
@property (nonatomic, strong) id params;                 //请求参数
@property (nonatomic, strong) id additionParams;         //图片，语音等

//params普通字符串参数
+ (RequestParam *)paramWithURL:(NSString *)requestUrl andParams:(id)params withPrefix:(NSString *)prefix;

//params普通字符串参数,additonPararms图片和语音等参数
+ (RequestParam *)paramWithURL:(NSString *)requestUrl andParams:(NSDictionary *)params additionParams:(NSDictionary *)additonPararms withPrefix:(NSString *)prefix;

@end
