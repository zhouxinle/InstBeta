//
//  InstgramUser.m
//  InstgramBeta
//
//  Created by zhouxinle on 15-1-6.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "InstgramUser.h"

@implementation InstgramUser

@synthesize uid,phoneNumber,username,password;

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (id)initWithDic:(NSDictionary*)dic
{
    if (dic == nil || [dic count] <= 0) {
        return nil;
    }
    
    if (self = [super init]) {
        self.uid = [[dic objectForKey:@"uid"] longLongValue];
        self.phoneNumber = [dic objectForKey:@"phoneNumber"];
        self.username = [dic objectForKey:@"uname"];
        self.password = [dic objectForKey:@"password"];
    }
    
    return self;
}

@end
