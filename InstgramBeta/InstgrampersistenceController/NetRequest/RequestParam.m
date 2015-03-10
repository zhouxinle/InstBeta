//
//  RequestParam.m
//  GeitWorkOrderManager
//
//  Created by zhouxinle on 13-12-13.
//  Copyright (c) 2013年 imac. All rights reserved.
//

#import "RequestParam.h"

@implementation RequestParam

@synthesize requestUrl;
@synthesize callBackPrefix;
@synthesize params;


+ (RequestParam *)paramWithURL:(NSString *)requestUrl andParams:(id)params withPrefix:(NSString *)prefix
{
    RequestParam* requestParam = [[RequestParam alloc] init];
    
    requestParam.requestUrl = requestUrl;
    requestParam.callBackPrefix = prefix;
    requestParam.params = params;
    
    return requestParam;
}

+ (RequestParam *)paramWithURL:(NSString *)requestUrl andParams:(NSDictionary *)params additionParams:(NSDictionary *)additonPararms withPrefix:(NSString *)prefix
{
    RequestParam* requestParam = [[RequestParam alloc] init];
    
    requestParam.requestUrl = requestUrl;
    requestParam.callBackPrefix = prefix;
    requestParam.params = params;
    requestParam.additionParams = additonPararms;
    
    return requestParam;
}

@end
