//
//  ObserveObject.m
//  GeitWorkOrderManager
//
//  Created by zhouxinle on 13-12-13.
//  Copyright (c) 2013年 imac. All rights reserved.
//

#import "ObserveObject.h"

@implementation ObserveObject

@synthesize object;

- (id)initWithObject:(id)obj
{
    if (self = [super init])
    {
        object = obj;
    }
    
    return self;
}


@end
