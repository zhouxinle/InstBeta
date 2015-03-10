//
//  InstgramRootActionController.h
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-31.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstgramRootActionController : NSObject
{
    NSMutableArray* _delegateArray;
}

- (void)addObserver:(id)delegate;
- (void)removeObserver:(id)delegate;

@end
