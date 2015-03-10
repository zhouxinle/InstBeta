//
//  InstgramHTTPRequest+Account.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-31.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramHTTPRequest+Account.h"

@implementation InstgramHTTPRequest (Account)

#pragma mark - Public Interface

- (void)instagramRegist:(NSString*)phoneNumber password:(NSString*)password
{
    NSDictionary* postDic = [NSDictionary dictionaryWithObjectsAndKeys:phoneNumber,@"phoneNumber",password,@"password", nil];
    
    RequestParam* postParam = [RequestParam paramWithURL:REGIST_ACTION andParams:postDic withPrefix:ACCOUNT_CALLBACK_PREFIX];
    [self postAsynHTTPRequest:postParam];
}

- (void)instagramPerfectUserInfo:(NSData*)profileImageData nickName:(NSString*)nickName
{
    NSDictionary* paramsDic = nil;
    if ([NSString stringIsNoEmpty:nickName]) {
        paramsDic = [NSDictionary dictionaryWithObjectsAndKeys:nickName,@"userName",[NSNumber numberWithInt:10],@"age", nil];
    }

    NSDictionary* additonParamsDic = nil;
    if (profileImageData != nil && profileImageData.length > 0 ) {
        additonParamsDic = [NSDictionary dictionaryWithObjectsAndKeys:profileImageData,@"profile", nil];
    }
    RequestParam* postParam = [RequestParam paramWithURL:PERFRCTUSREINFO_ACTION andParams:paramsDic additionParams:additonParamsDic withPrefix:ACCOUNT_CALLBACK_PREFIX];
    [self postAsynHTTPRequest:postParam];
}

#pragma mark - Private Methods

#pragma mark - AccountInterfaceHTTPCallBack

- (void)onAccountRequestSucc:(NSArray*)array
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
        [self onAccountBroadcastRequestFailed:params withError:[self errorWithCode:ReqErrorCodeServiceNoContent]];
        return;
    }
    
    @try {
        //json解析
        //基类转子类要类型判断，这里responseObject就属于转子类
//        NSString* responseJsonString = [[NSString alloc] initWithData:(NSData*)responseObject encoding:NSUTF8StringEncoding];
//        NSError* praseError = nil;
//        id responseDic = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingAllowFragments error:&praseError];
//        if (praseError) {
//            //json解析错误
//            [self onAccountBroadcastRequestFailed:params withError:[self errorWithCode:ReqErrorCodeParseError]];
//        }else
//        {
            //json解析错误
            if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self onAccountBroadcastRequestFailed:params withError:[self errorWithCode:ReqErrorCodeParseError]];
            }
            else
            {
                if ([responseObject count] <= 0)
                {
                    [self onAccountBroadcastRequestFailed:params withError:[self errorWithCode:ReqErrorCodeServiceNoContent]];
                }else{
                    int statusCode = [[(NSDictionary*)responseObject objectForKey:@"status"] intValue];
                    if (statusCode == 200) {
                        [self onAccountDispatchRequestSucc:params withResult:(NSDictionary*)responseObject];
                    }else{
                        [self onAccountBroadcastRequestFailed:params withError:[self errorWithCode:statusCode]];
                    }
                }
            }
        //}
    }
    @catch (NSException *exception) {
            //json解析错误异常
            [self onAccountBroadcastRequestFailed:params withError:[self errorWithCode:ReqErrorCodeParseError]];
    }
    @finally {
        
    }
    
    
}

- (void)onAccountRequestFailure:(NSArray*)array
{
    UNUSED_VAR AFHTTPRequestOperation* operation = (AFHTTPRequestOperation*)[array objectAtIndex:0];
    UNUSED_VAR NSError* error = (NSError*)[array objectAtIndex:1];
    UNUSED_VAR RequestParam* params = (RequestParam*)[array objectAtIndex:2];
    
    [self onAccountBroadcastRequestFailed:params withError:error];
}

//成功广播
- (void)onAccountDispatchRequestSucc:(RequestParam*)requestParam withResult:(NSDictionary*)resultValue
{
    //注册成功回调
    if ([requestParam.requestUrl isEqualToString:REGIST_ACTION]) {
        [self registSuccCallBackToAC:requestParam result:resultValue];
    }
}

//失败广播
- (void)onAccountBroadcastRequestFailed:(RequestParam*)requestParam withError:(NSError*)error
{
    if ([requestParam.requestUrl isEqualToString:REGIST_ACTION]) {
        [self registFailCallBackToAC:requestParam error:error];
    }
}

//成功dispatch
//注册成功
- (void)registSuccCallBackToAC:(RequestParam*)resultParam result:(NSDictionary*)resultValue
{
    @synchronized(self){
        for (ObserveObject* obsObj in _delegateArray)
        {
            id item = obsObj.object;
            if ([item respondsToSelector:@selector(onRegistSucc:result:)]) {
                [item onRegistSucc:resultParam result:resultValue];
            }
        }
    }
}

//失败dispatch
//注册失败
- (void)registFailCallBackToAC:(RequestParam*)param error:(NSError*)error
{
    @synchronized(self){
        for (ObserveObject* obsObj in _delegateArray)
        {
            id<InstgramHTTPRequestAccountDelegate> item = obsObj.object;
            if ([item respondsToSelector:@selector(onRegistFailure:error:)]) {
                [item onRegistFailure:param error:error];
            }
        }
    }
}

@end
