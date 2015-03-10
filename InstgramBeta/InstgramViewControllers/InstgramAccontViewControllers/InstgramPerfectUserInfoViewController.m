//
//  InstgramPerfectUserInfoViewController.m
//  InstgramBeta
//
//  Created by zhouxinle on 15-1-13.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "InstgramPerfectUserInfoViewController.h"
#import "instgramUserInfoCell.h"
#import "instgramAccountActionController.h"
#import "InstgramSetNickNameViewController.h"
#import "InstgramMainViewController.h"

@interface InstgramPerfectUserInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView* _userInfoTableView;
    NSArray* _titleArray;
}

@end

@implementation InstgramPerfectUserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self.navigationItem setHidesBackButton:YES];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupParams];
    [self setupController];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[InstgramAccountActionController sharedInstance] removeObserver:self];
}

#pragma mark - Private Methods

- (void)setupController
{
    [[InstgramAccountActionController sharedInstance] addObserver:self];
}

- (void)setupParams
{
    _titleArray = @[@"表情",@"昵称"];
}

- (void)setupView
{
    [self setNavigationTitle:@"完善资料"];
    [self setNextTimeBarItem];
    
    
    _userInfoTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _userInfoTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [_userInfoTableView setBackgroundColor:[UIColor clearColor]];
    _userInfoTableView.delegate = self;
    _userInfoTableView.dataSource = self;
    [_userInfoTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_userInfoTableView];
}

#pragma mark - Button Methods

- (void)onNextTimeAction:(id)sender
{
    //下次再说，直接进入主界面
    InstgramMainViewController* mainVC = [[InstgramMainViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:mainVC animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 65;
    }else if (indexPath.row == 1)
    {
        return 40;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* userInfoIdentifier = @"userInfoIdentifierCell";
    InstgramUserInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:userInfoIdentifier];
    if (cell == nil) {
        cell = [[InstgramUserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:userInfoIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    }
    
    switch (indexPath.row) {
        case 0:
            [cell fillTheCellWithContent:[NSDictionary dictionaryWithObjectsAndKeys:[_titleArray objectAtIndex:0],@"title",@"image",@"type", nil]];
            break;
        case 1:
            [cell fillTheCellWithContent:[NSDictionary dictionaryWithObjectsAndKeys:[_titleArray objectAtIndex:1],@"title",@"text",@"type", nil]];
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0: //选取头像
        {
            UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"选取头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册选取", nil];
            [sheet showInView:self.view];
            break;
        }
        case 1: //设置昵称
        {
            InstgramSetNickNameViewController* setNickNameVC = [[InstgramSetNickNameViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:setNickNameVC animated:YES];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0://拍照
            [self openImagePickerControllerWith:UIImagePickerControllerSourceTypeCamera];
            break;
        case 1://相册选择
            [self openImagePickerControllerWith:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
            
        default:
            break;
    }
}

#pragma mark - UIImagePickerController

- (void)openImagePickerControllerWith:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = type;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)processImage:(NSDictionary*)info
{
    UIImage* editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        @autoreleasepool {
            UIImage *scaledImage = [editedImage resizedImageWithMaximumSize:CGSizeMake(200, 200)];
            NSData *webUploadData = UIImageJPEGRepresentation(scaledImage, 1);
            NSLog(@"%u",webUploadData.length);
            
            //上传头像
            [[InstgramAccountActionController sharedInstance] instagramPerfectUserInfo:webUploadData nickName:nil];

            //图片处理完成，刷新UI界面
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//                InstgramUserInfoCell* profileCell = (InstgramUserInfoCell*)[_userInfoTableView cellForRowAtIndexPath:indexPath];
//                [profileCell.profileButton setImageWithData:webUploadData];
//            });
        }
    });

}

#pragma mark - UIImagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (info != nil) {
        [self performSelector:@selector(processImage:) withObject:info afterDelay:0.1f];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];

}

@end
