//
//  InstgramHTTPRequest+Account.h
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-31.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramHTTPRequest.h"
#import "InstgramHTTPRequestAccountDelegate.h"

#pragma mark - Request URL
//注册
static NSString* REGIST_ACTION = @"registAction";
//完善资料
static NSString* PERFRCTUSREINFO_ACTION = @"perfectUserInfoAction";

#pragma mark - Macros

#define ACCOUNT_CALLBACK_PREFIX         @"Account"

@interface InstgramHTTPRequest (Account)

#pragma mark - Public Interface

- (void)instagramRegist:(NSString*)phoneNumber password:(NSString*)password;

- (void)instagramPerfectUserInfo:(NSData*)profileImageData nickName:(NSString*)nickName;


@end
