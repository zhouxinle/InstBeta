//
//  InstgramCoreTextCell.h
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstgramCoreTextView.h"

@interface InstgramCoreTextCell : UITableViewCell

//真实项目
@property (nonatomic, strong) InstgramCoreTextView* coreTextView;
//test
@property (nonatomic, strong) UILabel* textLabel;

- (void)setCellValue:(NSString*)originalText;
+ (CGFloat)caculateCellHeight:(NSString*)originalText;

@end
