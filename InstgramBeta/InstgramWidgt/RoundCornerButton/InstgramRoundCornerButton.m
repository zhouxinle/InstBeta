//
//  InstgramRoundCornerButton.m
//  InstgramBeta
//
//  Created by zhouxinle on 15-1-13.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "InstgramRoundCornerButton.h"

@implementation InstgramRoundCornerButton

- (id)initWithPoint:(CGPoint)centerPoint badge:(NSString *)badge avatarButtonSnsType:(InstagramAvatarButtonSnsType)snsType Radius:(InstagramAvatarButtonRadius)radius
{
    if (self = [super initWithFrame:CGRectMake(centerPoint.x -   radius, centerPoint.y - radius, radius * 2, radius * 2)]) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.layer.masksToBounds = NO; //不设置圆角button
        
        UIImageView* avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, radius * 2, radius * 2)];
        avatarImageView.tag = 800;
        avatarImageView.contentMode                 = UIViewContentModeScaleAspectFit;
        avatarImageView.userInteractionEnabled      = NO;
        //设置圆角图片
        avatarImageView.layer.cornerRadius          = self.frame.size.width / 2;
        avatarImageView.layer.masksToBounds         = YES;
        avatarImageView.layer.borderWidth           = 3.f;
        avatarImageView.layer.borderColor           = [[UIColor colorWithHex:0xffffff] CGColor];
        avatarImageView.backgroundColor = [UIColor clearColor];
        [avatarImageView setImage:[UIImage imageNamed:@"icon_default_friend"]];
        [self addTarget:self action:@selector(onAvatarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:avatarImageView];
    }
    return self;
}

-(void)setImageWithData:(NSData *)data {
    if (data != nil) {
        UIImageView *avatarImageView = (UIImageView*)[self viewWithTag:800];
        [avatarImageView setImage:[UIImage imageWithData:data]];
    }
}

#pragma mark - Button Methods

- (void)onAvatarButtonClicked:(id)sender
{
    
}

@end
