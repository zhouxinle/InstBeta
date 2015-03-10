//
//  PersonalPageHeaderView.h
//  InstgramBeta
//
//  Created by zhouxinle on 15-1-26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstgramRoundCornerButton.h"

typedef NS_ENUM(NSInteger, LoadDataType) {
    InitialSetUp            = 0,          //初始化
    LoadData                = 1,          //加载完数据
};

@interface PersonalPageHeaderView : UIView

@property (nonatomic, assign) LoadDataType loadDataType;

@property (nonatomic, strong) InstgramRoundCornerButton* profileButton;
@property (nonatomic, strong) UILabel* showCountLabel;
@property (nonatomic, strong) UILabel* showCountTextLabel;
@property (nonatomic, strong) UILabel* followersCountLabel;
@property (nonatomic, strong) UILabel* followersTextLabel;
@property (nonatomic, strong) UILabel* flowersCountLabel;
@property (nonatomic, strong) UILabel* flowersTextLabel;
@property (nonatomic, strong) UIButton* actionButton;
@property (nonatomic, strong) UILabel* descriptionLabel;
@property (nonatomic, strong) UILabel* ownPageLabel;

@property (nonatomic, strong) UIButton* collectViewButton;
@property (nonatomic, strong) UIButton* tableViewButton;
@property (nonatomic, strong) UIButton* mapViewButton;

+ (CGFloat)caculateDescriptionTextHeight:(NSString*)description;
+ (CGFloat)caculateOwnPageTextHeigh:(NSString*)ownPage;
+ (CGFloat)caculateHeight:(LoadDataType)type;

- (void)setViewValue:(NSDictionary*)valueDictionary;

@end
