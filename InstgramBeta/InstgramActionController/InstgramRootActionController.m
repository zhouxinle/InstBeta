//
//  InstgramRootActionController.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-31.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramRootActionController.h"
#import "ObserveObject.h"

@implementation InstgramRootActionController

- (id)init
{
    if (self = [super init]) {
        _delegateArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return self;
}

- (void)addObserver:(id)delegate
{
    @synchronized(self)
    {
        
        ObserveObject* object = [[ObserveObject alloc] initWithObject:delegate];
        [_delegateArray addObject:object];
        
    }
}

- (void)removeObserver:(id)delegate
{
    
    @synchronized(self)
    {
        
        if (_delegateArray != nil)
        {
            for (ObserveObject* item in _delegateArray)
            {
                if (item.object == delegate)
                {
                    [_delegateArray removeObject:item];
                    break;
                }
            }
        }
        
    }
}

@end
