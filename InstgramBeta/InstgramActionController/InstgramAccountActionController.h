//
//  InstgramAccountActionController.h
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-31.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramRootActionController.h"
#import "InstgramActionAccontDelegate.h"
#import "InstgramUser.h"

@interface InstgramAccountActionController : InstgramRootActionController

@property (nonatomic,strong) InstgramUser* currentUser;

//单例类
AS_SINGLETON(InstgramAccountActionController);

#pragma mark - Public Interface 

- (void)instagramRegist:(NSString*)phoneNumber password:(NSString*)password;

- (void)instagramPerfectUserInfo:(NSData*)profileImageData nickName:(NSString*)nickName;

@end
