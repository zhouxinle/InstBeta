//
//  PersonalPageHeaderView.m
//  InstgramBeta
//
//  Created by zhouxinle on 15-1-26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "PersonalPageHeaderView.h"

@implementation PersonalPageHeaderView
@synthesize profileButton,showCountLabel,showCountTextLabel,followersCountLabel,followersTextLabel,flowersCountLabel,flowersTextLabel,actionButton,descriptionLabel,ownPageLabel,collectViewButton,tableViewButton,mapViewButton;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.profileButton = [[InstgramRoundCornerButton alloc] initWithPoint:CGPointMake(frame.origin.x + 12 + InstagramAvatarButtonRadius30, frame.origin.y + 12 + InstagramAvatarButtonRadius30) badge:nil avatarButtonSnsType:InstagramAvatarButtonSnsTypeNone Radius:InstagramAvatarButtonRadius30];
        [self addSubview:self.profileButton];
        
        self.showCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x + 12 + self.profileButton.bounds.size.width + 50, frame.origin.y + 12, 30, 18)];
        [self.showCountLabel setTextAlignment:NSTextAlignmentCenter];
        [self.showCountLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
        [self.showCountLabel setTextColor:[UIColor blackColor]];
        [self addSubview:self.showCountLabel];
        
        self.showCountTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.showCountLabel.frame.origin.x, self.showCountLabel.frame.origin.y + self.showCountLabel.bounds.size.height + 4, 30, 16)];
        [self.showCountTextLabel setTextAlignment:NSTextAlignmentCenter];
        [self.showCountTextLabel setFont:[UIFont fontWithName:kDefaultFontName size:15.0f]];
        [self.showCountTextLabel setTextColor:[UIColor colorWithHex:kFontColorGray]];
        [self.showCountTextLabel setText:@"帖子"];
        [self addSubview:self.showCountTextLabel];
        
        self.followersCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 35 - 30, self.frame.origin.y + 12, 30, 18)];
        [self.followersCountLabel setTextAlignment:NSTextAlignmentCenter];
        [self.followersCountLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
        [self.followersCountLabel setTextColor:[UIColor blackColor]];
        [self addSubview:self.followersCountLabel];

        self.followersTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.followersCountLabel.frame.origin.x, self.flowersCountLabel.frame.origin.y + self.followersCountLabel.bounds.size.height + 4, 30, 16)];
        [self.followersTextLabel setTextAlignment:NSTextAlignmentCenter];
        [self.followersTextLabel setFont:[UIFont fontWithName:kDefaultFontName size:15.0f]];
        [self.followersTextLabel setTextColor:[UIColor colorWithHex:kFontColorGray]];
        [self.followersTextLabel setText:@"关注"];
        [self addSubview:self.followersTextLabel];
        
        CGFloat widthGap = self.followersCountLabel.frame.origin.x - (self.showCountLabel.frame.origin.x + self.showCountLabel.frame.size.width);
        
        self.flowersCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.showCountLabel.frame.origin.x + self.showCountLabel.bounds.size.width + widthGap / 2 - 30 / 2, self.frame.origin.y + 12, 30, 18)];
        [self.flowersCountLabel setTextAlignment:NSTextAlignmentCenter];
        [self.flowersCountLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
        [self.flowersCountLabel setTextColor:[UIColor blackColor]];
        [self addSubview:self.flowersCountLabel];
        
        self.flowersTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.flowersCountLabel.frame.origin.x, self.flowersCountLabel.frame.origin.y, 30, 16)];
        [self.flowersTextLabel setTextAlignment:NSTextAlignmentCenter];
        [self.flowersTextLabel setFont:[UIFont fontWithName:kDefaultFontName size:15.0f]];
        [self.flowersTextLabel setTextColor:[UIColor colorWithHex:kFontColorGray]];
        [self.flowersTextLabel setText:@"粉丝"];
        [self addSubview:self.flowersTextLabel];
        
        self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.actionButton.frame = CGRectMake(self.profileButton.frame.origin.x + self.profileButton.frame.size.width + 25,self.showCountTextLabel.frame.origin.y + self.showCountTextLabel.bounds.size.height + 9,self.frame.size.width - self.actionButton.frame.origin.x - 12,28);
        [self.actionButton setBackgroundImage:[[UIImage imageNamed:@"login_buttonbg_normal"]  stretchImage]forState:UIControlStateNormal];
        [self.actionButton setBackgroundImage:[[UIImage imageNamed:@"login_buttonbg_highlighted"] stretchImage] forState:UIControlStateHighlighted];
        [self.actionButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.actionButton addTarget:self action:@selector(onTouchAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.actionButton];
        
            self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, self.profileButton.frame.origin.y + self.profileButton.frame.size.height + 25, self.bounds.size.width - 12 * 2, MAXFLOAT)];
            self.descriptionLabel.numberOfLines = 0;
            self.descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
            [self.descriptionLabel setBackgroundColor:[UIColor orangeColor]];
            UIFont* font = [UIFont fontWithName:@"Helvetica" size:15.0f];
            self.descriptionLabel.font = font;
        
            //[self addSubview:self.descriptionLabel];
        
        [self drawRectWithViewRect:CGRectMake(0, self.bounds.size.height - 45.5, self.bounds.size.width, 0.5) color:[UIColor colorWithHex:kFontColorGray]];
        
        self.collectViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.collectViewButton setFrame:CGRectMake(0, self.bounds.size.height - 45, 320 / 3, 45)];
        [self.collectViewButton setBackgroundColor:[UIColor orangeColor]];
        [self.collectViewButton setTitle:@"九宫格" forState:UIControlStateNormal];
        [self addSubview:self.collectViewButton];
        
        self.tableViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.tableViewButton setFrame:CGRectMake(self.collectViewButton.frame.origin.x + self.collectViewButton.bounds.size.width, self.bounds.size.height - 45, 320 / 3, 45)];
        [self.tableViewButton setBackgroundColor:[UIColor greenColor]];
        [self.tableViewButton setTitle:@"表格" forState:UIControlStateNormal];
        [self addSubview:self.tableViewButton];
        
        self.mapViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.mapViewButton setFrame:CGRectMake(self.tableViewButton.frame.origin.x + self.tableViewButton.bounds.size.width, self.bounds.size.height - 45, 320 / 3, 45)];
        [self.mapViewButton setBackgroundColor:[UIColor greenColor]];
        [self.mapViewButton setTitle:@"地图" forState:UIControlStateNormal];
        [self addSubview:self.mapViewButton];
        
        
        [self drawRectWithViewRect:CGRectMake(0, self.bounds.size.height - 0.5, self.bounds.size.width, 0.5) color:[UIColor colorWithHex:kFontColorGray]];
    }
    return self;
}

+ (CGFloat)caculateHeight:(LoadDataType)type
{
    switch (type) {
        case InitialSetUp:
            return 12 + 60 + 10 + 45;
            break;
        default:
            break;
    }
    
    return 0;
}

+ (CGFloat)caculateDescriptionTextHeight:(NSString*)description;
{
    CGSize size = [description sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15.0f]constrainedToSize:CGSizeMake(320 - 12 * 2, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height;
}

+ (CGFloat)caculateOwnPageTextHeigh:(NSString*)ownPage
{
    return 0;
}

+ (CGFloat)caculateHeight:(NSString*)description OwnPage:(NSString*)ownPageText
{
    return [[self class] caculateDescriptionTextHeight:description] + [[self class] caculateOwnPageTextHeigh:ownPageText] + 180;
}

- (void)setViewValue:(NSDictionary*)valueDictionary
{
    NSString* description = [valueDictionary objectForKey:@"description"];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height + [[self class] caculateDescriptionTextHeight:description] + 10)];
    [self addSubview:self.descriptionLabel];
    [self.descriptionLabel setFrame:CGRectMake(self.descriptionLabel.frame.origin.x, self.descriptionLabel.frame.origin.y, self.descriptionLabel.bounds.size.width, [[self class] caculateDescriptionTextHeight:description])];
    [self.descriptionLabel setText:description];
}

#pragma mark - Button Methods

- (void)onTouchAction:(id)sender
{
    
}

@end
