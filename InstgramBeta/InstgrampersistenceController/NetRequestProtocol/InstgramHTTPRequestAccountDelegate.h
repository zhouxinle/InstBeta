//
//  InstgramHTTPRequestAccountDelegate.h
//  InstgramBeta
//
//  Created by zhouxinle on 15-1-5.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestParam.h"

@protocol InstgramHTTPRequestAccountDelegate <NSObject>

@optional

//注册接口回调
- (void)onRegistSucc:(RequestParam*)requestParam result:(NSDictionary*)result;
- (void)onRegistFailure:(RequestParam*)requestParam error:(NSError*)error;

@end
