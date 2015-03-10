//
//  InstgramRootViewController.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramRootViewController.h"

@interface InstgramRootViewController ()

@end

@implementation InstgramRootViewController

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
    
    [self setupCommonBg];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupCommonBg
{
    UIImageView* bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [bgImageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [bgImageView setImage:[UIImage imageNamed:@"commonBg.png"]];
    [self.view addSubview:bgImageView];
}

#pragma mark - Public Methods

- (void)setNavigationTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 160, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.navigationItem setTitleView:titleLabel];
}

// 设置返回按钮
- (void)setBackBarItem
{
    UIButton* btnCloseMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCloseMenu setFrame:CGRectMake(0, 0, 45, 45)]; // frame.size.width - 40, 10, 32, 32
    //[btnCloseMenu setBackgroundColor:[UIColor clearColor]];
    //    [btnCloseMenu setBackgroundImage:[UIImage imageNamed:@"navigationBar_button_bg_highlight"] forState:UIControlStateHighlighted];
    [btnCloseMenu setImage:[UIImage imageNamed:@"navigationBar_back_icon"] forState:UIControlStateNormal];
    [btnCloseMenu setImage:[UIImage imageNamed:@"navigationBar_back_icon1"] forState:UIControlStateHighlighted];
    btnCloseMenu.adjustsImageWhenHighlighted = NO;// default is YES. if YES, image is drawn darker when highlighted(pressed)
    [btnCloseMenu addTarget:self action:@selector(onBackAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnCloseMenu];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
}

// 设置关闭按钮
- (void)setCloseBarItem
{
    UIButton* btnCloseMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCloseMenu setFrame:CGRectMake(0, 0, 45, 45)]; // frame.size.width - 40, 10, 32, 32
    //btnCloseMenu.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    [btnCloseMenu setBackgroundColor:[UIColor clearColor]];
    [btnCloseMenu setImage:[UIImage imageNamed:@"navigationBar_close_btn"] forState:UIControlStateNormal];
    [btnCloseMenu setImage:[UIImage imageNamed:@"navigationBar_close_btn1"] forState:UIControlStateHighlighted];
    //    [btnCloseMenu setBackgroundImage:[UIImage imageNamed:@"navigationBar_button_bg_highlight"] forState:UIControlStateHighlighted];
    btnCloseMenu.adjustsImageWhenHighlighted = NO;
    [btnCloseMenu addTarget:self action:@selector(onCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnCloseMenu];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
}

// 设置下次再说按钮
- (void)setNextTimeBarItem
{
    UIButton *btnNextTimeMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnNextTimeMenu setTitle:@"下次再说" forState:UIControlStateNormal];
    [btnNextTimeMenu.titleLabel  setFont:[UIFont fontWithName:kDefaultFontName size:14.0f]];
    [btnNextTimeMenu setFrame:CGRectMake(3,7, 60, 30)];
    btnNextTimeMenu.tag = 900;
    [btnNextTimeMenu setBackgroundImage:[[UIImage imageNamed:@"btn_next_time_normal"] stretchImage] forState:UIControlStateNormal];
    [btnNextTimeMenu setBackgroundImage:[[UIImage imageNamed:@"btn_next_time_highlighted"] stretchImage] forState:UIControlStateHighlighted];
    [btnNextTimeMenu addTarget:self action:@selector(onNextTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnNextTimeMenu];
    [self.navigationItem setRightBarButtonItem:barButtonItem];

}

// 设置完成按钮
- (void)setSaveBarItem
{
    UIButton *btnSaveMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSaveMenu setTitle:@"保存" forState:UIControlStateNormal];
    [btnSaveMenu.titleLabel  setFont:[UIFont fontWithName:kDefaultFontName size:14.0f]];
    [btnSaveMenu setFrame:CGRectMake(3,7, 60, 30)];
    btnSaveMenu.tag = 900;
    [btnSaveMenu setBackgroundImage:[[UIImage imageNamed:@"btn_next_time_normal"] stretchImage] forState:UIControlStateNormal];
    [btnSaveMenu setBackgroundImage:[[UIImage imageNamed:@"btn_next_time_highlighted"] stretchImage] forState:UIControlStateHighlighted];
    [btnSaveMenu addTarget:self action:@selector(onSaveAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnSaveMenu];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
}

#pragma mark - Button Methods

- (void)onBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onCloseAction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)onNextTimeAction:(id)sender
{
    
}

- (void)onSaveAction:(id)sender
{
    
}

@end
