//
//  UIView+DrawRect.m
//  GeitWorkOrderManager
//
//  Created by zhouxinle on 13-12-5.
//  Copyright (c) 2013年 imac. All rights reserved.
//

#import "UIView+DrawRect.h"

@implementation UIView (DrawRect)

- (void) drawRectWithViewRect:(CGRect)viewrect color:(UIColor *)color;{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(self.layer.position.x-self.frame.origin.x,self.layer.position.y-self.frame.origin.y)];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[color CGColor]];
    [shapeLayer setLineWidth:viewrect.size.height];
    [shapeLayer setLineJoin:kCALineJoinRound];
    CGPoint spoint =  CGPointMake(viewrect.origin.x, viewrect.origin.y+viewrect.size.height/2);
    CGPoint epoint = CGPointMake(viewrect.origin.x+viewrect.size.width,viewrect.origin.y+viewrect.size.height/2);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL,spoint.x,spoint.y);
    CGPathAddLineToPoint(path, NULL,epoint.x,spoint.y);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [[self layer] addSublayer:shapeLayer];
}

@end
