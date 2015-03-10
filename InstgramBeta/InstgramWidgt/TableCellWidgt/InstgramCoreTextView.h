//
//  InstgramCoreTextView.h
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-29.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstgramCoreTextView : UIView

@property (nonatomic, copy) NSString* text;
@property (nonatomic, strong) UIFont* textFont;
@property (nonatomic, strong) UIColor* textColor;
@property (nonatomic, assign) float lineSpacing;  //行间距

@property (nonatomic, strong) NSMutableArray* runsArray;
@property (nonatomic, strong) NSMutableDictionary* responseTouchRunRectDic;

- (CGFloat)caculateHeight;
//- (void)drawText;

@end
