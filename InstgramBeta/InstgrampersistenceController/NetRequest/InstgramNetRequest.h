//
//  InstgramNetRequest.h
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-31.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "RequestParam.h"
#import "ObserveObject.h"

typedef NS_ENUM(NSInteger, HTTPRequestErrorCodeType)
{
    ReqErrorCodeServiceNoContent = 1001,       // 无返回结果
    ReqErrorCodeParseError = 1002,             // 返回结果解析错误
    ReqErrorCodeUsernameOrPasswordError = 1003,//用户名密码错误
    ReqErrorCodeReturnFailError = 1004,             // 返回失败
    ReqErrorCodeTimedOut = 1005,                //连接超时
    ReqErrorCodeCannotConnectToHost = 1006,     //无法连接到服务器
    ReqErrorCodeNetworkConnectionLost = 1007,   //连接丢失
    ReqErrorCodeNoNetWork = 1008,                //无法连接网络
    ReqErrorCodeUnknownError = 1009,                  //未知错误
    ReqErrorCodePhoneNumberRegisted = 410,       //手机号已经注册
    ReqErrorCodeDataBaseOperateFailure = 409,    //数据库操作失败
};

static NSString* const ReqErrServiceNoContent = @"未返回内容。";
static NSString* const ReqErrParseError = @"返回内容解析错误。";
static NSString* const ReqErrUnamePasswordError = @"用户名或密码错误";
static NSString* const ReqErrorReturnFailError = @"返回失败";
static NSString* const ReqErrTimedOut = @"连接超时";
static NSString* const ReqErrCannotConnectToHost = @"无法连接到服务器";
static NSString* const ReqErrNetworkConnectionLost = @"连接丢失";
static NSString* const ReqErrNoNetWork = @"网络无法连接";
static NSString* const ReqErrUnknownError = @"未知错误";

static NSString* const ReqErrPhoneNumberRegisted = @"该手机号已经被注册";
static NSString* const ReqErrRegistFailure = @"注册失败";

#define USER_CUSTOM_ERROR_CODE  (100001)


@interface InstgramNetRequest : NSObject
{
    NSMutableArray* _delegateArray;          //委托数组
    AFHTTPRequestOperationManager* _afHTTPRequestOperationManager;
}

#pragma mark - Public Methods

@property (nonatomic, strong) AFHTTPRequestOperationManager* afHTTPRequestOperationManager;

- (void)addObserver:(id)delegate;        //增加委托对象
- (void)removeObserver:(id)delegate;     //移除委托对象

- (void)postAsynHTTPRequest:(RequestParam*)requestParam;   //发起异步请求

- (NSError*)errorWithCode:(HTTPRequestErrorCodeType)errorCode;
@end
