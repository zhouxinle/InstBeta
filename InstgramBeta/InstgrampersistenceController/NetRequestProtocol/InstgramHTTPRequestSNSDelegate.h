//
//  InstgramHTTPRequestSNSDelegate.h
//  InstgramBeta
//
//  Created by zhouxinle on 15-1-28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InstgramHTTPRequestSNSDelegate <NSObject>

@optional

//查看个人主页接口回调
- (void)onViewPersonalPageSucc:(RequestParam*)requestParam result:(NSDictionary*)result;
- (void)onViewPersonalPageFailure:(RequestParam*)requestParam error:(NSError*)error;

@end
