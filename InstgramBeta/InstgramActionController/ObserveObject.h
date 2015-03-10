//
//  ObserveObject.h
//  GeitWorkOrderManager
//
//  Created by zhouxinle on 13-12-13.
//  Copyright (c) 2013年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObserveObject : NSObject

@property (nonatomic, weak) id object;

- (id)initWithObject:(id)obj;

@end
