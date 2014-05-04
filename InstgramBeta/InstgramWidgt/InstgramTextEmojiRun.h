//
//  InstgramTextEmojiRun.h
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-29.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramTextBaseRun.h"

static  NSString* emojiTextStartMark = @"[";
static  NSString* emojiTextEndMark = @"]";

@interface InstgramTextEmojiRun : InstgramTextBaseRun



+ (NSString*)analyseText:(NSString*)text andRunsObjectArray:(NSMutableArray**)runsArray;

@end
