//
//  InstgramUserInfoCell.m
//  InstgramBeta
//
//  Created by zhouxinle on 15-1-13.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "InstgramUserInfoCell.h"

@implementation InstgramUserInfoCell

@synthesize titleLabel,valueLabel,profileButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //设置cell背景色
        //[self setBackgroundColor:[UIColor orangeColor]];
        //[self setFrame:CGRectMake(0, 0, 320, 1000)];
        NSLog(@"%f",self.bounds.size.height);
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 60, 18)];
//        [self.titleLabel setCenter:CGPointMake(15 + self.titleLabel.bounds.size.width / 2, self.center.y)];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.titleLabel];
        
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - 15*2 - self.titleLabel.bounds.size.width - 80, 17)];
//        [self.valueLabel setCenter:CGPointMake(15 + self.titleLabel.bounds.size.width + 80 + self.valueLabel.bounds.size.width / 2, self.center.y)];
        [self.valueLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [self.valueLabel setTextColor:[UIColor colorWithHex:kFontColorGray]];
        [self.valueLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.valueLabel];
        
        self.profileButton = [[InstgramRoundCornerButton alloc] initWithPoint:CGPointZero badge:nil avatarButtonSnsType:InstagramAvatarButtonSnsTypeNone Radius:InstagramAvatarButtonRadius25];
        [self.contentView addSubview:self.profileButton];
    }
    return self;
}

- (void)fillTheCellWithContent:(NSDictionary*)content
{
    if (content == nil || [content count] <= 0) {
        return;
    }
    NSLog(@"%f",self.frame.size.height);

    NSString* title = [content objectForKey:@"title"];
    NSString* type = [content objectForKey:@"type"];
    
    if ([type isEqualToString:@"text"]) {
        //[self setFrame:CGRectMake(0, 0, 320, 45)];

        [self.profileButton setHidden:YES];
        [self.valueLabel setHidden:NO];
        
        [self.titleLabel setText:title];
        [self.valueLabel setText:@"未填写"];
        
    }else if ([type isEqualToString:@"image"])
    {
        //[self setFrame:CGRectMake(0, 0, 320, 65)];
        
        [self.profileButton setHidden:NO];
        [self.valueLabel setHidden:YES];
        
        [self.titleLabel setText:title];
        [self.valueLabel setText:nil];
    }
//    [self.titleLabel setCenter:CGPointMake(15 + self.titleLabel.bounds.size.width / 2, self.bounds.size.height / 2)];
//    [self.valueLabel setCenter:CGPointMake(15 + self.titleLabel.bounds.size.width + 80 + self.valueLabel.bounds.size.width / 2, self.bounds.size.height / 2)];
//
//    [self.profileButton setFrame:CGRectMake(0, 0, InstagramAvatarButtonRadius25 * 2, InstagramAvatarButtonRadius25 * 2)];
//    [self.profileButton setCenter:CGPointMake(self.bounds.size.width - 15 - self.profileButton.bounds.size.width / 2, self.bounds.size.height / 2)];
//    [self drawRectWithViewRect:CGRectMake(8, self.bounds.size.height - 0.5, self.bounds.size.width - 8 * 2, 0.5) color:[UIColor colorWithHex:0xe5e5e5]];
}

//最后调用,这个函数中cell高度对了
- (void)layoutSubviews
{
    NSLog(@"%f",self.frame.size.height);
    [self.titleLabel setCenter:CGPointMake(15 + self.titleLabel.bounds.size.width / 2, self.bounds.size.height / 2)];
    [self.valueLabel setCenter:CGPointMake(15 + self.titleLabel.bounds.size.width + 80 + self.valueLabel.bounds.size.width / 2, self.bounds.size.height / 2)];
    
    [self.profileButton setFrame:CGRectMake(0, 0, InstagramAvatarButtonRadius25 * 2, InstagramAvatarButtonRadius25 * 2)];
    [self.profileButton setCenter:CGPointMake(self.bounds.size.width - 15 - self.profileButton.bounds.size.width / 2, self.bounds.size.height / 2)];
    [self drawRectWithViewRect:CGRectMake(8, self.bounds.size.height - 0.5, self.bounds.size.width - 8 * 2, 0.5) color:[UIColor colorWithHex:0xe5e5e5]];

}

- (void)awakeFromNib {
    // Initialization code
    NSLog(@"%f",self.frame.size.height);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
