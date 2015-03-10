//
//  InstgramHotRankViewController.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramHotRankViewController.h"
#import "InstgramCoreTextCell.h"
#import "UIView+DrawRect.h"

@interface InstgramHotRankViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _showsTableView;
    NSString* _originalText;
}

@end

@implementation InstgramHotRankViewController

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
    
    [self setupParams];
    [self setupView];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)setupParams
{
    _originalText = @"飒飒撒飒 飒[017]大神大@acccccchttp://dsadasdasdjl.com";
}

- (void)setupView
{
    [self setNavigationTitle:@"Hot Show"];
    
    _showsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_showsTableView setBackgroundColor:[UIColor clearColor]];
    [_showsTableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [_showsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _showsTableView.delegate = self;
    _showsTableView.dataSource = self;
    [self.view addSubview:_showsTableView];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [InstgramCoreTextCell caculateCellHeight:_originalText];
    return height;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"CoreTextCell";
    InstgramCoreTextCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[InstgramCoreTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell drawRectWithViewRect:CGRectMake(0, cell.bounds.size.height - 0.5, 320, 0.5) color:[UIColor darkGrayColor]];
    }
    
    [cell setCellValue:_originalText];
    
    return cell;
}




@end
