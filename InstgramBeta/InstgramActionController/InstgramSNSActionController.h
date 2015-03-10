//
//  InstgramSNSActionController.h
//  InstgramBeta
//
//  Created by zhouxinle on 15-1-28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "InstgramRootActionController.h"
#import "instgramActionSNSDelegate.h"

@interface InstgramSNSActionController : InstgramRootActionController

AS_SINGLETON(InstgramSNSActionController);

#pragma mark - Public Interface

//查看个人主页
- (void)viewPersonalPage:(long long)uid;

@end
