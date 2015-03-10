//
//  InstgramRootViewController.h
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstgramRootViewController : UIViewController

//设置导航条标题
- (void)setNavigationTitle:(NSString*)title;
// 设置返回按钮
- (void)setBackBarItem;
// 设置关闭按钮
- (void)setCloseBarItem;
// 设置下次再说按钮
- (void)setNextTimeBarItem;
// 设置保存按钮
- (void)setSaveBarItem;
@end
