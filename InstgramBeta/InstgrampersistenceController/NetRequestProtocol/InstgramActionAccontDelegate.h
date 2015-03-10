//
//  InstgramActionAccontDelegate.h
//  InstgramBeta
//
//  Created by zhouxinle on 15-1-6.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InstgramActionAccontDelegate <NSObject>

@optional

//注册接口回调
- (void)registSucc;
- (void)registFailed:(NSError*)error;

@end
