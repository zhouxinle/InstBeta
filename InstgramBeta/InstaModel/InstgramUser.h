//
//  InstgramUser.h
//  InstgramBeta
//
//  Created by zhouxinle on 15-1-6.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstgramUser : NSObject

@property (nonatomic, assign) long long uid;
@property (nonatomic, copy) NSString* phoneNumber;
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* password;

- (id)initWithDic:(NSDictionary*)dic;

@end
