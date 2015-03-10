//
//  InstgramNetRequest.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-31.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramNetRequest.h"

@implementation InstgramNetRequest

@synthesize afHTTPRequestOperationManager = _afHTTPRequestOperationManager;

#pragma mark - Public Methods

- (id)init
{
    if (self = [super init]) {
        _delegateArray = [NSMutableArray arrayWithCapacity:0];
        
        if (self.afHTTPRequestOperationManager == nil) {
            AFHTTPRequestSerializer* afHTTPRequestSerializer = [AFHTTPRequestSerializer serializer];
//            [afHTTPRequestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//            [afHTTPRequestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [afHTTPRequestSerializer setTimeoutInterval:REQUEST_TIMEOUT];
            self.afHTTPRequestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:HTTPREQUEST_BASE_URL]];
            [self.afHTTPRequestOperationManager setRequestSerializer:afHTTPRequestSerializer];
//            self.afHTTPRequestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        }
    }
    
    return self;
}

/**
 *  增加委托对象
 *
 *  @param delegate 委托对象
 */
- (void)addObserver:(id)delegate
{
    @synchronized(self) {
        ObserveObject* observeObj = [[ObserveObject alloc] initWithObject:delegate];
        [_delegateArray addObject:observeObj];
    }
}

/**
 *  移除委托对象
 *
 *  @param delegate 委托对象
 */
- (void)removeObserver:(id)delegate
{
    
    @synchronized(self)
    {
        if (_delegateArray != nil)
        {
            for (ObserveObject* observeObj in _delegateArray)
            {
                if (observeObj.object == delegate)
                {
                    [_delegateArray removeObject:observeObj];
                    break;
                }
            }
        }
    }
}

//发起异步请求
- (void)postAsynHTTPRequest:(RequestParam *)requestParam
{
    if (requestParam.additionParams == nil)       //普通(参数)请求
    {
        [self.afHTTPRequestOperationManager POST:requestParam.requestUrl parameters:requestParam.params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //responseObject居然直接是字典
            [self onHttpRequestSucc:operation withResponse:responseObject withRequestParam:requestParam];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error = %@",error);
            
        }];
    }
    else{//MULTI-PART REQUEST  图片语音等
        [self.afHTTPRequestOperationManager POST:requestParam.requestUrl parameters:requestParam.params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            for (NSString* key in  [requestParam.additionParams allKeys])
            {
                //图片
                if ([key isEqualToString:@"profile"]) {
                    [formData appendPartWithFileData:[requestParam.additionParams objectForKey:key] name:key fileName:@"profile.jpg" mimeType:@"image/jpg"];
                }
            }
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"responseObj = %@",responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error = %@",error);
        }];
    }
}

- (NSError*)errorWithCode:(HTTPRequestErrorCodeType)errorCode
{
    NSString* errorString = nil;
    
    switch (errorCode) {
        case ReqErrorCodeServiceNoContent:
            errorString = ReqErrServiceNoContent;
            break;
        case ReqErrorCodeParseError:
            errorString = ReqErrParseError;
            break;
        case ReqErrorCodeUsernameOrPasswordError:
            errorString = ReqErrUnamePasswordError;
            break;
        case ReqErrorCodeReturnFailError:
            errorString = ReqErrorReturnFailError;
            break;
        case ReqErrorCodeCannotConnectToHost:
            errorString = ReqErrCannotConnectToHost;
            break;
        case ReqErrorCodeNetworkConnectionLost:
            errorString = ReqErrNetworkConnectionLost;
            break;
        case ReqErrorCodeTimedOut:
            errorString = ReqErrTimedOut;
            break;
        case ReqErrorCodeNoNetWork:
            errorString = ReqErrNoNetWork;
            break;
        case ReqErrorCodeUnknownError:
            errorString = ReqErrUnknownError;
            break;
        case ReqErrorCodePhoneNumberRegisted:
            errorString = ReqErrPhoneNumberRegisted;
            break;
        case ReqErrorCodeDataBaseOperateFailure:
            errorString = ReqErrRegistFailure;
            break;
        default:
            break;
    }
    
    NSError *error = [NSError errorWithDomain:HTTPREQUEST_BASE_URL code:USER_CUSTOM_ERROR_CODE userInfo:[NSDictionary dictionaryWithObjectsAndKeys:errorString, NSLocalizedDescriptionKey, [NSNumber numberWithInt:errorCode], @"errorCode", nil]];
    return error;
}

#pragma mark - Private Methods

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//HTTP请求成功回调
- (void)onHttpRequestSucc:(AFHTTPRequestOperation*)operation withResponse:(id)responseObject withRequestParam:(RequestParam*)requestParam
{
//    if (responseObject == nil) {
//        responseObject = @{};
//    }
    
    if (requestParam != nil && requestParam.callBackPrefix != nil)
    {
        SEL selector = NSSelectorFromString([NSString stringWithFormat:@"on%@RequestSucc:", requestParam.callBackPrefix]);

        if ([self respondsToSelector:selector]) {
            [self performSelector:selector withObject:[NSArray arrayWithObjects:operation, responseObject, requestParam, nil]];
        }
    }
}

//HTTP请求失败回调
- (void)onHttpRequestFailed:(AFHTTPRequestOperation*)operation withError:(NSError*)error withRequestParam:(RequestParam*)requestParam
{
    NSError* err = nil;
    
    if (error != nil && (error.code == NSURLErrorTimedOut ||
                         error.code == NSURLErrorCannotConnectToHost ||
                         error.code == NSURLErrorNetworkConnectionLost)) {
        switch (error.code) {
            case NSURLErrorTimedOut:
                err = [self errorWithCode:ReqErrorCodeTimedOut];
                break;
            case NSURLErrorCannotConnectToHost:
            {
                //检查是否有网络连接
                AFNetworkReachabilityManager* reachAbility =  [AFNetworkReachabilityManager managerForDomain:@"www.apple.com"];
                if ([reachAbility networkReachabilityStatus] == AFNetworkReachabilityStatusNotReachable) {
                    err = [self errorWithCode:ReqErrorCodeNoNetWork];
                }
                else err = [self errorWithCode:ReqErrorCodeCannotConnectToHost];
                break;
            }
            case NSURLErrorNetworkConnectionLost:
                err = [self errorWithCode:ReqErrorCodeNetworkConnectionLost];
                break;
                
            default:
                break;
        }
    }else
    {
        err = [self errorWithCode:ReqErrorCodeUnknownError];
    }
    
    if (requestParam != nil && requestParam.callBackPrefix != nil) {
        SEL selector = NSSelectorFromString([NSString stringWithFormat:@"on%@RequestFailure:", requestParam.callBackPrefix]);
        if ([self respondsToSelector:selector]) {
            [self performSelector:selector withObject:[NSArray arrayWithObjects:operation, err, requestParam, nil]];
        }
    }
}

@end
