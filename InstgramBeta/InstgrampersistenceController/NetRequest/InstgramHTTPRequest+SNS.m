//
//  InstgramHTTPRequest+SNS.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-31.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramHTTPRequest+SNS.h"

@implementation InstgramHTTPRequest (SNS)

#pragma mark - Public Interface

//查看个人主页
- (void)viewPersonalPage:(long long)uid
{
    NSDictionary* postDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:uid],@"uid", nil];
    RequestParam* requestParam = [RequestParam paramWithURL:VIEWPERSONALPAGE_ACTION andParams:postDic withPrefix:SNS_CALLBACK_PREFIX];
    [self postAsynHTTPRequest:requestParam];
}

#pragma mark - CallBack

- (void)onSNSRequestSucc:(NSArray*)array
{
    if (array == nil || [array count] != 3) {
        return;
    }
    
    UNUSED_VAR AFHTTPRequestOperation* operation = (AFHTTPRequestOperation*)[array objectAtIndex:0];
    UNUSED_VAR id responseObject = [array objectAtIndex:1];
    UNUSED_VAR RequestParam* params = (RequestParam*)[array objectAtIndex:2];
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSLog(@"字典！");
    }
    //无返回结果
    if (responseObject == nil)
    {
        [self onSNSBroadcastRequestFailed:params withError:[self errorWithCode:ReqErrorCodeServiceNoContent]];
        return;
    }
    
    @try {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            //解析错误
            [self onSNSBroadcastRequestFailed:params withError:[self errorWithCode:ReqErrorCodeParseError]];
        }
        else
        {
            if ([responseObject count] <= 0)
            {
                [self onSNSBroadcastRequestFailed:params withError:[self errorWithCode:ReqErrorCodeServiceNoContent]];
            }else{
                int statusCode = [[(NSDictionary*)responseObject objectForKey:@"status"] intValue];
                if (statusCode == 200) {
                    [self onSNSDispatchRequestSucc:params withResult:(NSDictionary*)responseObject];
                }else{
                    [self onSNSBroadcastRequestFailed:params withError:[self errorWithCode:statusCode]];
                }
            }
        }
        //}
    }
    @catch (NSException *exception) {
        //json解析错误异常
        [self onSNSBroadcastRequestFailed:params withError:[self errorWithCode:ReqErrorCodeParseError]];
    }
    @finally {
        
    }
}

- (void)onSNSRequestFailure:(NSArray*)array
{
    UNUSED_VAR AFHTTPRequestOperation* operation = (AFHTTPRequestOperation*)[array objectAtIndex:0];
    UNUSED_VAR NSError* error = (NSError*)[array objectAtIndex:1];
    UNUSED_VAR RequestParam* params = (RequestParam*)[array objectAtIndex:2];
    
    [self onSNSBroadcastRequestFailed:params withError:error];
}

//成功广播
- (void)onSNSDispatchRequestSucc:(RequestParam*)requestParam withResult:(NSDictionary*)resultValue
{
    //查看个人主页成功回调
    if ([requestParam.requestUrl isEqualToString:VIEWPERSONALPAGE_ACTION]) {
        [self viewPersonalPageSuccCallBackToAC:requestParam result:resultValue];
    }
}

//失败广播
- (void)onSNSBroadcastRequestFailed:(RequestParam*)requestParam withError:(NSError*)error
{
    if ([requestParam.requestUrl isEqualToString:VIEWPERSONALPAGE_ACTION]) {
        [self viewPersonalPageFailCallBackToAC:requestParam error:error];
    }
}

//查看个人主页成功
- (void)viewPersonalPageSuccCallBackToAC:(RequestParam*)requestParam result:(NSDictionary*)resultValue
{
    @synchronized(self){
        for (ObserveObject* obsObj in _delegateArray)
        {
            id<InstgramHTTPRequestSNSDelegate> item = obsObj.object;
            if ([item respondsToSelector:@selector(onViewPersonalPageSucc:result:)]) {
                [item onViewPersonalPageSucc:requestParam result:resultValue];
            }
        }
    }
}

//查看个人主页失败
- (void)viewPersonalPageFailCallBackToAC:(RequestParam*)requestParam error:(NSError*)error
{
    @synchronized(self){
        for (ObserveObject* obsObj in _delegateArray)
        {
            id<InstgramHTTPRequestSNSDelegate> item = obsObj.object;
            if ([item respondsToSelector:@selector(onViewPersonalPageFailure:error:)]) {
                [item onViewPersonalPageFailure:requestParam error:error];
            }
        }
    }
}
@end
