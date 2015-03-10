//
//  InstgramActionSNSDelegate.h
//  InstgramBeta
//
//  Created by zhouxinle on 15-1-28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InstgramActionSNSDelegate <NSObject>

@optional

- (void)viewPersonalPageSucc:(NSDictionary*)result;
- (void)viewPersonalPageFailed:(NSError*)error;

@end
