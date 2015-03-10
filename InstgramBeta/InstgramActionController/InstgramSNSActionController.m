//
//  InstgramSNSActionController.m
//  InstgramBeta
//
//  Created by zhouxinle on 15-1-28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "InstgramSNSActionController.h"
#import "InstgramHTTPRequest+SNS.h"

@interface InstgramSNSActionController()<InstgramHTTPRequestSNSDelegate>
{
    
}

@end

@implementation InstgramSNSActionController

DEF_SINGLETON(InstgramSNSActionController);

- (id)init
{
    if (self = [super init])
    {
        [self setupActionController];
    }
    
    return self;
}

#pragma mark - Private Methods

- (void)dealloc
{
    [[InstgramHTTPRequest sharedInstance] removeObserver:self];
}

- (void)setupActionController
{
    [[InstgramHTTPRequest sharedInstance] addObserver:self];
}

#pragma mark - Public Interface

//查看个人主页
- (void)viewPersonalPage:(long long)uid
{
    [[InstgramHTTPRequest sharedInstance] viewPersonalPage:uid];
}

#pragma mark - InstgramHTTPRequestSNSDelegate

- (void)onViewPersonalPageSucc:(RequestParam *)requestParam result:(NSDictionary *)result
{
    @synchronized(self){
        for (ObserveObject* obj in _delegateArray)
        {
            id<InstgramActionSNSDelegate> item = obj.object;
            if ([item respondsToSelector:@selector(viewPersonalPageSucc:)]) {
                [item viewPersonalPageSucc:result];
            }
        }
    }
}

- (void)onViewPersonalPageFailure:(RequestParam *)requestParam error:(NSError *)error
{
    @synchronized(self){
        for (ObserveObject* obj in _delegateArray)
        {
            id<InstgramActionSNSDelegate> item = obj.object;
            if ([item respondsToSelector:@selector(viewPersonalPageFailed:)]) {
                [item viewPersonalPageFailed:error];
            }
        }
    }
}

@end
