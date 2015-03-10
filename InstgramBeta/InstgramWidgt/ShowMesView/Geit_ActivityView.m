//
//  Geit_ActivityView.m
//  GeitWorkOrderManager
//
//  Created by 小白 on 13-12-18.
//  Copyright (c) 2013年 imac. All rights reserved.
//

#import "Geit_ActivityView.h"


@implementation Geit_ActivityView
@synthesize flag=_flag;
//DEF_SINGLETON(Geit_ActivityView);
+ (Geit_ActivityView *)sharedInstance
{ \
    static dispatch_once_t once;
    static Geit_ActivityView * __singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[Geit_ActivityView alloc] init]; } );
    return __singleton__;
}

- (void)showAttention:(UIView *)view detail:(NSString *)detail
{
    MBProgressHUD *toast = [MBProgressHUD showHUDAddedTo:view animated:YES];
    toast.mode = MBProgressHUDModeText;
    toast.labelText = detail;
    toast.margin = 10.f;
    toast.yOffset = view.bounds.size.height / 2 - 80;
    toast.removeFromSuperViewOnHide = YES;
    [toast hide:YES afterDelay:1.0f];
}

- (void)showActivity:(UIView *)view detail:(NSString *)detail
{
    _hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    _hud.labelText = detail;
}

- (void)hideActivity:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}
- (float)getIphoneHeight
{
     CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    if (screenHeight==568) {
        return 44.0;
    }
    return 0.0;
}

- (float)setTextSizeWithLabelSize:(CGSize)size StringLength:(NSString *)string
{
    NSString *trimString=[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //float tempLenth=trimString.length*gTextFieldFont*96/72;
    CGSize rtnSize;
    
    float fontSize=kTextFieldFont;
    float tempLength;
    float tempHeight;
    rtnSize=[self getCGSizeOfText:trimString withFont:fontSize];
    tempLength=rtnSize.width;
    tempHeight=rtnSize.height;
    //NSLog(@"string=%@,length=%f,height=%f,templength=%f",string,size.width,size.height,tempLength);
    while (tempLength>=size.width&&tempHeight>size.height/2) {
        fontSize--;
        rtnSize=[self getCGSizeOfText:trimString withFont:fontSize];
        tempLength=rtnSize.width;
        tempHeight=rtnSize.height;
    }
    //NSLog(@"fontSize=%f",fontSize);
    return fontSize;
    //else return length*72/string.length/96;
}

- (float)setTextSizeWithTextFieldSize:(CGSize)size StringLength:(NSString *)string
{
    NSString *trimString=[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //float tempLenth=trimString.length*gTextFieldFont*96/72;
    CGSize rtnSize;
    
    float fontSize=kTextFieldFont;
    float tempLength;
    float tempHeight;
    rtnSize=[self getCGSizeOfText:trimString withFont:fontSize];
    tempLength=rtnSize.width;
    tempHeight=rtnSize.height;
    //NSLog(@"string=%@,length=%f,height=%f,templength=%f",string,size.width,size.height,tempLength);
    while (tempLength>=size.width) {
        fontSize--;
        rtnSize=[self getCGSizeOfText:trimString withFont:fontSize];
        tempLength=rtnSize.width;
        tempHeight=rtnSize.height;
    }
    //NSLog(@"fontSize=%f",fontSize);
    return fontSize;
    //else return length*72/string.length/96;
}
//参考方法：根据文字长度和字体大小得出所需要的长度和宽度

- (CGSize)getCGSizeOfText:(NSString *)title withFont:(float)fontSize
{
    
    CGSize constraint = CGSizeMake(1000, 20000.0f);
    CGSize size = CGSizeZero;
    if (IOS6_OR_LATER) {
        NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:title attributes:@{
                                                                                                          NSFontAttributeName:[UIFont systemFontOfSize:fontSize]
                                                                                                          }];
        CGRect rect = [attributedText boundingRectWithSize:constraint
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        size = rect.size;
    }else{
        size = [title sizeWithFont:[UIFont systemFontOfSize:fontSize] forWidth:constraint.width lineBreakMode:NSLineBreakByCharWrapping];
    }
    //NSLog(@"size_width=%f,size_height=%f",size.width,size.height);
    return size;
}

- (void)setAnimation:(UIView *)view withAnimationType:(NSString *)name withFromDirection:( NSString *)direction
{
    if (_flag) {
        CATransition *animation = [CATransition animation];
        animation.duration = .5f;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;//开始和结束慢，中间块
        animation.fillMode = kCAFillModeForwards;
        animation.type=name;
        animation.subtype = direction;
        [view.layer addAnimation:animation forKey:nil];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
