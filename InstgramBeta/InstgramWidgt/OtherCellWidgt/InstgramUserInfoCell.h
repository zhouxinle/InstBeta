//
//  InstgramUserInfoCell.h
//  InstgramBeta
//
//  Created by zhouxinle on 15-1-13.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstgramRoundCornerButton.h"

@interface InstgramUserInfoCell : UITableViewCell

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* valueLabel;
@property (nonatomic, strong) InstgramRoundCornerButton* profileButton;

- (void)fillTheCellWithContent:(NSDictionary*)content;

@end
