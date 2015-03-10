//
//  InstgramHTTPRequest+SNS.h
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-31.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramHTTPRequest.h"
#import "InstgramHTTPRequestSNSDelegate.h"

#pragma mark - Request URL
//查看个人主页
static NSString* VIEWPERSONALPAGE_ACTION = @"viewPersonMainPageAction";

#pragma mark - Macros

#define SNS_CALLBACK_PREFIX         @"SNS"

@interface InstgramHTTPRequest (SNS)

#pragma mark - Public Interface
//查看个人主页
- (void)viewPersonalPage:(long long)uid;

@end
