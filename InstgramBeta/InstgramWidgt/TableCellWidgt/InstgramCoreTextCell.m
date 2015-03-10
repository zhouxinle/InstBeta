//
//  InstgramCoreTextCell.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramCoreTextCell.h"

@implementation InstgramCoreTextCell

@synthesize coreTextView;
@synthesize textLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setFrame:CGRectMake(0, 0, 320, 1000)];
        [self setBackgroundColor:[UIColor clearColor]];
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.textLabel setBackgroundColor:[UIColor orangeColor]];
        [self.textLabel setFont:[UIFont systemFontOfSize:17]];
        [self.textLabel setTextColor:[UIColor blackColor]];
        [self.textLabel setTextAlignment:NSTextAlignmentLeft];
        self.textLabel.numberOfLines = 0;
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:self.textLabel];
    }
    return self;
}

- (void)setCellValue:(NSString*)originalText
{
    NSMutableAttributedString* attributeStr = [InstgramCoreTextCell analyzeOriginalText:originalText];
    CGFloat labelHeight = [InstgramCoreTextCell caculateCellHeight:originalText];
    [self.textLabel setFrame:CGRectMake(20, 0, 280, labelHeight)];
    [self.textLabel setAttributedText:attributeStr];
}

+ (NSMutableAttributedString*)analyzeOriginalText:(NSString*)originalText
{
    //创建一个可变的属性字符串
    NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] initWithString:originalText];
    
    UIFont *baseFont = [UIFont systemFontOfSize:17];
    //设置可变字符串字体
    [attributeString addAttribute:(NSString*)NSFontAttributeName value:(id)baseFont range:NSMakeRange(0, originalText.length)];
    
    NSError* error = nil;

    //识别@
    NSString* atPattern = @"(@[\u4e00-\u9fa5a-zA-Z0-9_]+)";
    NSRegularExpression* atRegularExpression = [NSRegularExpression regularExpressionWithPattern:atPattern options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) {
        NSLog(@"error = %@",error);
    }
    NSArray* atArray = [atRegularExpression matchesInString:originalText options:0 range:NSMakeRange(0, originalText.length)];
    
    for (NSTextCheckingResult* result in atArray)
    {
        //设置at的颜色为红色
        NSRange atRange = result.range;
        NSLog(@"atRange = %@",NSStringFromRange(atRange));
        [attributeString addAttribute:(NSString*)NSForegroundColorAttributeName value:[UIColor redColor] range:atRange];
    }
    
    //识别文本中的表情，@，http
    //识别url
    NSString* urlPattern = @"(https?|ftp|file)://[-A-Z0-9+&#/%?=~_|!:,.;]*[-A-Z0-9+&#/%=~_|]";
    error = nil;
    NSRegularExpression* urlRegularExpression = [NSRegularExpression regularExpressionWithPattern:urlPattern options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) {
        NSLog(@"error = %@",error);
    }
    NSArray* urlArray = [urlRegularExpression matchesInString:originalText options:0 range:NSMakeRange(0, originalText.length)];
    
    for (NSTextCheckingResult* result in urlArray)
    {
        //设置url的颜色为红色
        NSRange urlRange = result.range;
        NSLog(@"urlRange = %@",NSStringFromRange(urlRange));
        [attributeString addAttribute:(NSString*)NSForegroundColorAttributeName value:[UIColor greenColor] range:urlRange];
    }
    

    
    //识别表情
    NSString * emojiPattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    error = nil;
    NSRegularExpression* emojiRegularExpression = [NSRegularExpression regularExpressionWithPattern:emojiPattern options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) {
        NSLog(@"error = %@",error);
    }
    
    
    //表情字符串匹配数组
    NSArray* emojiStringArray = [emojiRegularExpression matchesInString:originalText options:0 range:NSMakeRange(0, originalText.length)];
    //用来存放字典，字典中存储的是图片和图片对应的位置
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:emojiStringArray.count];
    
    for (NSTextCheckingResult* result in emojiStringArray)
    {
        //获取表情字符串在整个str中的range
        NSRange range = [result range];
        
        //获取原字符串中对应的值
        NSString *subStr = [originalText substringWithRange:range];
        
        
        if ([@"[017]" isEqualToString:subStr])
        {
            //face[i][@"gif"]就是我们要加载的图片
            //新建文字附件来存放我们的图片
            NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
            
            //给附件添加图片  图片大小最好跟字体大小一样大 17*17
            textAttachment.image = [UIImage imageNamed:@"017"];
            
            //把附件转换成可变字符串，用于替换掉源字符串中的表情文字

            NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];

            //把图片和图片对应的位置存入字典中
            NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
            [imageDic setObject:imageStr forKey:@"image"];
            [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
            
            //把字典存入数组中
            [imageArray addObject:imageDic];
        }
    }

    //从后往前替换表情
    for (NSInteger i = imageArray.count -1; i >= 0; i--)
    {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
    }
    return attributeString;
}

+ (CGFloat)caculateCellHeight:(NSString *)originalText
{
    NSMutableAttributedString* attributeString = [InstgramCoreTextCell analyzeOriginalText:originalText];
    CGRect textBound = [attributeString boundingRectWithSize:CGSizeMake(280, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return textBound.size.height;
}

//@和url相应触摸事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //触摸的point
    CGPoint touchLocation = [(UITouch *)[touches anyObject] locationInView:self];
}

@end
