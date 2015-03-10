//
//  InstgramPersonalViewController.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-4-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramPersonalViewController.h"
#import "PersonalPageHeaderView.h"
#import "InstgramSNSActionController.h"

@interface InstgramPersonalViewController ()<UITableViewDataSource,UITableViewDelegate,InstgramActionSNSDelegate>
{
    UITableView* _personalTableView;
    PersonalPageHeaderView* _headerView;
}

@end

@implementation InstgramPersonalViewController

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
    
}

- (void)setupView
{
    [self setNavigationTitle:@"Personal"];

    _personalTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_personalTableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    _personalTableView.delegate = self;
    _personalTableView.dataSource = self;
    [_personalTableView setTableHeaderView:[[PersonalPageHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, [PersonalPageHeaderView caculateHeight:InitialSetUp])]];
    [self.view addSubview:_personalTableView];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark - InstgramActionSNSDelegate

- (void)viewPersonalPageSucc:(NSDictionary *)result
{
    
}

- (void)viewPersonalPageFailed:(NSError *)error
{
    
}

@end
