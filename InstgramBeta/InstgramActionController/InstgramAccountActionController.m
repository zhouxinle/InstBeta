//
//  InstgramAccountActionController.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-31.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramAccountActionController.h"
#import "InstgramHTTPRequest+Account.h"

@interface InstgramAccountActionController ()<InstgramHTTPRequestAccountDelegate>

@end

@implementation InstgramAccountActionController

@synthesize currentUser;

//单例方法,初始化单例类对象
DEF_SINGLETON(InstgramAccountActionController);

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

- (void)instagramRegist:(NSString*)phoneNumber password:(NSString*)password
{
    //参数判断TODO
    
    [[InstgramHTTPRequest sharedInstance] instagramRegist:phoneNumber password:password];
}

- (void)instagramPerfectUserInfo:(NSData*)profileImageData nickName:(NSString*)nickName
{
    [[InstgramHTTPRequest sharedInstance] instagramPerfectUserInfo:profileImageData nickName:nickName];
}

#pragma mark - InstgramHTTPRequestAccountDelegate

- (void)onRegistSucc:(RequestParam *)requestParam result:(NSDictionary *)result
{
    NSDictionary* userDic = [result objectForKey:@"user"];
    //当前注册用户
    self.currentUser = [[InstgramUser alloc] initWithDic:userDic];
    
    @synchronized(self){
        for (ObserveObject* obj in _delegateArray)
        {
            id item = obj.object;
            if ([item respondsToSelector:@selector(registSucc)]) {
                [item registSucc];
            }
        }
    }
    
}

- (void)onRegistFailure:(RequestParam *)requestParam error:(NSError *)error
{
    @synchronized(self){
        for (ObserveObject* obj in _delegateArray)
        {
            id item = obj.object;
            if ([item respondsToSelector:@selector(registFailed:)]) {
                [item registFailed:error];
            }
        }
    }
}

@end
