//
//  InstgramCoreTextView.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-29.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramCoreTextView.h"
#import "InstgramTextEmojiRun.h"
#import "InstgramTextUrlRun.h"
#import "InstgramTextAtRun.h"

@interface InstgramCoreTextView()
{
    NSMutableAttributedString* attString;
}

@end

@implementation InstgramCoreTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //计算当前view高度
        
        //self setFrame:<#(CGRect)#>
        self.runsArray = [NSMutableArray arrayWithCapacity:0];
        self.responseTouchRunRectDic = [NSMutableDictionary dictionaryWithCapacity:0];

    }
    return self;
}






- (void)setText:(NSString *)text
{
    _text = text;
    //[self setNeedsDisplay];
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    //[self setNeedsDisplay];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    //[self setNeedsDisplay];
}

- (void)setLineSpacing:(float)lineSpacing
{
    _lineSpacing = lineSpacing;
    //[self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    NSLog(@"rect = %@",NSStringFromCGRect(rect));
    // Drawing code

    //绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //修正坐标系//已当前view的左下角为原点
    CGAffineTransform textTran = CGAffineTransformIdentity;
    //移动坐标，y坐标增加self.bounds.size.height，也就是y轴向下移动self.bounds.size.height
    textTran = CGAffineTransformMakeTranslation(0.0, self.bounds.size.height);
    //放射缩放 向x轴正方向缩放0.5 y轴负方向缩放0.5
    textTran = CGAffineTransformScale(textTran, 1.0, -1.0);
    CGContextConcatCTM(context, textTran);
    
    CFRange lineRange = CFRangeMake(0, 0);
    CTTypesetterRef typeSetter = CTTypesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attString);
    float lineDrawX = 0;
    float lineDrawY = self.bounds.origin.y + self.bounds.size.height - _textFont.ascender;
    
    BOOL drawFlag = YES;
    
    
    while (drawFlag)
    {
        //CTTypesetterSuggestLineBreak 遇到英文单词不会分行显示。
        CFIndex everyLineCharacterNum = CTTypesetterSuggestLineBreak(typeSetter,lineRange.location,self.bounds.size.width);
    
        CTLineRef line;
        CFArrayRef runs;
        //越界标志
        BOOL outOfLine = NO;
        
        while (outOfLine == NO)
        {
            lineRange = CFRangeMake(lineRange.location,everyLineCharacterNum);
            NSLog(@"%ld",everyLineCharacterNum);
             line = CTTypesetterCreateLine(typeSetter, lineRange);
             runs = CTLineGetGlyphRuns(line);
            NSLog(@"%ld",CFArrayGetCount(runs));
            
            //边界检查
            //最后一个run
            CTRunRef lastRun = CFArrayGetValueAtIndex(runs, CFArrayGetCount(runs) - 1);
            CGFloat lastRunAscent;
            CGFloat laseRunDescent;
            //最后一个run的宽度
            CGFloat lastRunWidth  = CTRunGetTypographicBounds(lastRun, CFRangeMake(0,0), &lastRunAscent, &laseRunDescent, NULL);
//            //最后一个run的起点x坐标
            CGFloat lastRunPointX = lineDrawX + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(lastRun).location, NULL);
        
            if (lastRunPointX + lastRunWidth <= self.bounds.size.width) {
                outOfLine = YES;
            }
            else
            {
                everyLineCharacterNum --;
            }
        
            CFRelease(lastRun);
        }
        
        
        //绘制普通文本
        lineDrawX = CTLineGetPenOffsetForFlush(line,0,self.bounds.size.width);
        CGContextSetTextPosition(context,lineDrawX,lineDrawY);
        CTLineDraw(line,context);
        
        
        for (int i = 0; i < CFArrayGetCount(runs); i++)
        {
            //获取当前run
            CTRunRef runRef = CFArrayGetValueAtIndex(runs, i);
            NSDictionary* attributes = (__bridge NSDictionary*)CTRunGetAttributes(runRef);
            //获取特殊（表情和url）run
            InstgramTextBaseRun* run = [attributes objectForKey:@"RunType"];
            
            if (run)
            {
                CGFloat runAscent,runDescent;
                //特殊run宽度
                CGFloat runWidth  = CTRunGetTypographicBounds(runRef, CFRangeMake(0,0), &runAscent, &runDescent, NULL);
                NSLog(@"+++++++++++runWidth = %f",runWidth);
                NSLog(@"$$$$$$$$$$$$$run.text = %@",run.originalText);
                //特殊run高度
                CGFloat runHeight = runAscent + (-runDescent);
                //当前run 起点x坐标
                CGFloat runPointX = lineDrawX + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(runRef).location, NULL);
                CGFloat runPointY = lineDrawY - (-runDescent);
                
                CGRect runRect = CGRectMake(runPointX, runPointY, runWidth, runHeight);
                
                //绘制表情和url图标
                BOOL isDraw = [run drawRunWithRect:runRect];
                
                //url和@响应点击
                    if (run.isResponseTouch)
                    {
                        [self.responseTouchRunRectDic setObject:run forKey:[NSValue valueWithCGRect:runRect]];
                    }
                    else{
                        runRect = CTRunGetImageBounds(runRef, context, CFRangeMake(0, 0));
                        runRect.origin.x = runPointX;
                        [self.responseTouchRunRectDic setObject:run forKey:[NSValue valueWithCGRect:runRect]];
                    }
                
            }
            
            CFRelease(runRef);
            
        }
        
        //WHY???
        //CFRelease(line);
       // CFRelease(runs);
        
        if(lineRange.location + lineRange.length >= attString.length)
        {
            drawFlag = NO;
        }
        
        //下一行draw的起点y坐标
        //  第一行:  float drawLineY = self.bounds.origin.y + self.bounds.size.height - self.font.ascender;
        lineDrawY -= _textFont.ascender + (- _textFont.descender) + _lineSpacing;
        //下一行起点location
        lineRange.location += lineRange.length;
    }
    CFRelease(typeSetter);
}


- (CGFloat)caculateHeight
{
    //表情符用@" "代替 其他不变
    NSString* analyzedText = [self analyseText:_text];
    
     attString = [[NSMutableAttributedString alloc] initWithString:analyzedText];
    
    //设置字体
    CTFontRef aFont = CTFontCreateWithName((__bridge CFStringRef)_textFont.fontName, _textFont.pointSize, NULL);
    //设置需要绘制文字的字体
    [attString addAttribute:(NSString*)kCTFontAttributeName value:(__bridge id)aFont range:NSMakeRange(0,attString.length)];
    CFRelease(aFont);
    
    //设置颜色
    [attString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)_textColor.CGColor range:NSMakeRange(0,attString.length)];
    
    //遍历runs数组，设置url的颜色，将表情占位符@" "变为图片占位符(回调设置了图片占位符的上缘，下缘和高度)
    for (InstgramTextBaseRun* run in self.runsArray)
    {
        [run attributedStringAddAttribute:attString];
    }
    
    //计算行数
    CFRange lineRange = CFRangeMake(0, 0);
    CTTypesetterRef typeSetter = CTTypesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attString);
    float lineDrawX = 0;
   // float lineDrawY = self.bounds.origin.y + self.bounds.size.height - _textFont.ascender;
    
    BOOL drawFlag = YES;
    
    int lineNum = 0;
    
    while (drawFlag)
    {
        lineNum++;
        //CTTypesetterSuggestLineBreak 遇到英文单词不会分行显示。
        CFIndex everyLineCharacterNum = CTTypesetterSuggestLineBreak(typeSetter,lineRange.location,self.bounds.size.width);
        
        CTLineRef line;
        CFArrayRef runs;
        //越界标志
        BOOL outOfLine = NO;
        
        while (outOfLine == NO)
        {
            lineRange = CFRangeMake(lineRange.location,everyLineCharacterNum);
            NSLog(@"%ld",everyLineCharacterNum);
            line = CTTypesetterCreateLine(typeSetter, lineRange);
            runs = CTLineGetGlyphRuns(line);
            NSLog(@"%ld",CFArrayGetCount(runs));
            
            //边界检查
            //最后一个run
            CTRunRef lastRun = CFArrayGetValueAtIndex(runs, CFArrayGetCount(runs) - 1);
            CGFloat lastRunAscent;
            CGFloat laseRunDescent;
            //最后一个run的宽度
            CGFloat lastRunWidth  = CTRunGetTypographicBounds(lastRun, CFRangeMake(0,0), &lastRunAscent, &laseRunDescent, NULL);
            //            //最后一个run的起点x坐标
            CGFloat lastRunPointX = lineDrawX + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(lastRun).location, NULL);
            
            if (lastRunPointX + lastRunWidth <= self.bounds.size.width) {
                outOfLine = YES;
            }
            else
            {
                everyLineCharacterNum --;
            }
            
            CFRelease(lastRun);
        }
        
        
        //绘制普通文本
        lineDrawX = CTLineGetPenOffsetForFlush(line,0,self.bounds.size.width);

        
        if(lineRange.location + lineRange.length >= attString.length)
        {
            drawFlag = NO;
        }
        
        //下一行draw的起点y坐标
        //  第一行:  float drawLineY = self.bounds.origin.y + self.bounds.size.height - self.font.ascender;
        //lineDrawY -= _textFont.ascender + (- _textFont.descender) + _lineSpacing;
        //下一行起点location
        lineRange.location += lineRange.length;
    }
    CFRelease(typeSetter);
    
    NSLog(@"lineNum = %d",lineNum);
    CGFloat height = lineNum*(_textFont.ascender+(-_textFont.descender))+(lineNum-1)*_lineSpacing;
    NSLog(@"height = %f",height);
    return height;
}





- (NSString*)analyseText:(NSString*)text
{
    NSMutableArray* runs = self.runsArray;
    
    //原始text中的表情字符串换成@" "，返回替换表情字符串后的新字符串；  并且在self.runsArray中加入InstgramTextEmojiRun对象
    NSString* analyedText = [InstgramTextEmojiRun analyseText:text andRunsObjectArray:&runs];
    
    //利用正则找出text中的url，用@" "代替，在self.runsArray中加入InstgramTextUrlRun对象
    analyedText = [InstgramTextUrlRun analyseText:analyedText andRunsObjectArray:&runs];
    
    //利用正则找出@，在self.runsArray中加入InstgramTextAtRun对象
    analyedText = [InstgramTextAtRun analyseText:analyedText andRunsObjectArray:&runs];
    

    //设置run的字体,和文本字体保持一致
    //self.runArray中的3类对象都调用基类InstgramTextBaseRun的设置字体的方法
    [self.runsArray makeObjectsPerformSelector:@selector(setOriginalFont:) withObject:_textFont];
    
    return analyedText;
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [(UITouch *)[touches anyObject] locationInView:self];
    CGPoint runLocation = CGPointMake(location.x, self.frame.size.height - location.y);

    //遍历run字典
        [self.responseTouchRunRectDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
         {
             //__weak TQRichTextView *weakSelf = self;
             CGRect rect = [((NSValue *)key) CGRectValue];
             InstgramTextBaseRun *run = obj;
             //还可以根据run的类型，做出相应的动作
             if(CGRectContainsPoint(rect, runLocation))
             {
                 //[weakSelf.delegage richTextView:weakSelf touchEndRun:run];
                 NSLog(@"run.text = %@",run.originalText);

                 if ([run isKindOfClass:[InstgramTextUrlRun class]]) {
                     NSLog(@"url");
                 }
                 else if ([run isKindOfClass:[InstgramTextAtRun class]])
                 {
                     NSLog(@"at");
                 }
             }
         }];
}


@end
