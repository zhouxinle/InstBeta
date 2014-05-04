//
//  InstgramNearByViewController.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramNearByViewController.h"
#import "InstgramCoreTextView.h"

@interface InstgramNearByViewController ()

@end

@implementation InstgramNearByViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
    

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)setupView
{
    [self setNavigationTitle:@"Instgram"];
    
    //test
//    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 280, MAXFLOAT)];
//    label.numberOfLines = 0;
//    label.lineBreakMode = NSLineBreakByWordWrapping;
//    [label setBackgroundColor:[UIColor orangeColor]];
//    NSString* string = @"web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web web service web web web 你好你好web你好你好你好web你好你好你好web你好你好你好web你好hellololo你好web你好";
//    UIFont* font = [UIFont fontWithName:@"Helvetica" size:18.0f];
//    CGSize size = [string sizeWithFont:font constrainedToSize:CGSizeMake(label.bounds.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//    [label setFrame:CGRectMake(20, 50, 280, size.height + 5)];
//    label.font = font;
//    [label setText:string];
//    
//    [self.view addSubview:label];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    InstgramCoreTextView* coreView = [[InstgramCoreTextView alloc] initWithFrame:CGRectMake(20, self.view.bounds.origin.y + 20, 280, 0)];
    [coreView setBackgroundColor:[UIColor clearColor]];

    NSString* text = @"飒飒撒飒 飒[smile]大神大@achttp://dsadasdasdjl.com@大手大脚HASDJH熬枯受淡KJLASDD就阿斯顿甲ALKSDJ拉克丝http://adASDasdaSDasdADASDasdASDasdASDasd.com sadajskd的撒旦就啊；六十多级啊；拉斯克奖的；拉萨看见的dasjda;LKSJD;asjdlkASJDLk;asdjfadsfsafdshalkjfhaskldhfksadhfkasdhk倒萨大客户ASKDHADHKASFHWQU";
    [coreView setText:text];
    [coreView setTextColor:[UIColor blackColor]];
    [coreView setTextFont:[UIFont systemFontOfSize:17.0f]];
    [coreView setLineSpacing:1.5f];
    CGFloat height = [coreView caculateHeight];
//    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(coreView.bounds.size.width, MAXFLOAT)];
    [coreView setFrame:CGRectMake(20, 20, coreView.bounds.size.width, height)];

    [self.view addSubview:coreView];
    
    
}

@end
