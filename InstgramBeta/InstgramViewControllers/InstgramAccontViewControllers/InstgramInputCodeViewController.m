//
//  InstgramInputCodeViewController.m
//  InstgramBeta
//
//  Created by zhouxinle on 14-12-30.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "InstgramInputCodeViewController.h"
#import "Geit_ActivityView.h"
#import "InstgramSetPasswordViewController.h"

@interface InstgramInputCodeViewController ()<UITextFieldDelegate>
{
    UITextField* _mesIdentifyCodeTextField;
    int _seconds;
    UIButton* _secondsButton;
    NSTimer* _timer;
}

@end

@implementation InstgramInputCodeViewController

@synthesize phoneNumber;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSeconds];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)setupSeconds
{
    _seconds = 90;
}

- (void)setupView
{
    [self setNavigationTitle:@"输入短信验证码"];
    [self setBackBarItem];
    
    NSString* text = @"已经发送验证码至：";
    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:17.0f] byHeight:18.0f];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, textSize.width, textSize.height)];
    [label setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor darkGrayColor]];
    [label setFont:[UIFont systemFontOfSize:17.0f]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setText:text];
    [self.view addSubview:label];
    
    CGSize phoneNumSize = [self.phoneNumber sizeWithFont:[UIFont boldSystemFontOfSize:22.0f] byHeight:23.0f];
    UILabel* phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(label.frame.origin.x + label.bounds.size.width, 26, phoneNumSize.width, phoneNumSize.height)];
    [phoneNumLabel setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
    [phoneNumLabel setBackgroundColor:[UIColor clearColor]];
    [phoneNumLabel setTextColor:[UIColor blackColor]];
    [phoneNumLabel setFont:[UIFont boldSystemFontOfSize:22.0f]];
    [phoneNumLabel setTextAlignment:NSTextAlignmentLeft];
    [phoneNumLabel setText:self.phoneNumber];
    [self.view addSubview:phoneNumLabel];
    
    UIImageView* codeBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, phoneNumLabel.frame.origin.y + phoneNumLabel.bounds.size.height + 10 , 200, 45)];
    [codeBgImageView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
    [codeBgImageView setImage:[UIImage imageNamed:@"user_login_input"]];
    codeBgImageView.userInteractionEnabled = YES;
    [self.view addSubview:codeBgImageView];
    
    _mesIdentifyCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(codeBgImageView.bounds.origin.x + 10, codeBgImageView.bounds.origin.y, codeBgImageView.bounds.size.width - 20, codeBgImageView.bounds.size.height)];
    [_mesIdentifyCodeTextField setBorderStyle:UITextBorderStyleNone];
    _mesIdentifyCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _mesIdentifyCodeTextField.placeholder = @"请输入短信验证码";
    [_mesIdentifyCodeTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_mesIdentifyCodeTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    _mesIdentifyCodeTextField.textAlignment = NSTextAlignmentLeft;
    _mesIdentifyCodeTextField.textColor = [UIColor colorWithHex:kFontColorGray];
    _mesIdentifyCodeTextField.font = [UIFont fontWithName:kDefaultFontName size:kTextFieldFont];
    _mesIdentifyCodeTextField.returnKeyType = UIReturnKeyDone;
    _mesIdentifyCodeTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    _mesIdentifyCodeTextField.delegate = self;
    [_mesIdentifyCodeTextField addTarget:self action:@selector(onNextStepAction:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [codeBgImageView addSubview:_mesIdentifyCodeTextField];
    
    _secondsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _secondsButton.frame = CGRectMake(codeBgImageView.frame.origin.x + codeBgImageView.bounds.size.width + 5,codeBgImageView.frame.origin.y,self.view.bounds.size.width - codeBgImageView.frame.origin.x - codeBgImageView.bounds.size.width - 5 - 5,45);
    [_secondsButton setBackgroundImage:[[UIImage imageNamed:@"login_buttonbg_normal"]  stretchImage]forState:UIControlStateNormal];
    [_secondsButton setBackgroundImage:[[UIImage imageNamed:@"login_buttonbg_highlighted"] stretchImage] forState:UIControlStateHighlighted];
    [_secondsButton setTitle:[NSString stringWithFormat:@"%d",_seconds] forState:UIControlStateNormal];
    _secondsButton.userInteractionEnabled = NO;
    [self.view addSubview:_secondsButton];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateSecondsButton:) userInfo:nil repeats:YES];
    
    UIButton* nextstepButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextstepButton.frame = CGRectMake(10,codeBgImageView.frame.origin.y + codeBgImageView.bounds.size.height + 5,self.view.bounds.size.width - 20,40);
    [nextstepButton setBackgroundImage:[[UIImage imageNamed:@"login_buttonbg_normal"]  stretchImage]forState:UIControlStateNormal];
    [nextstepButton setBackgroundImage:[[UIImage imageNamed:@"login_buttonbg_highlighted"] stretchImage] forState:UIControlStateHighlighted];
    [nextstepButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextstepButton addTarget:self action:@selector(onNextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextstepButton];
}

- (void)onNextStepAction:(id)sender
{
    if ([NSString stringIsEmpty:_mesIdentifyCodeTextField.text]) {
        [_mesIdentifyCodeTextField resignFirstResponder];
        [[Geit_ActivityView sharedInstance] showAttention:self.view detail:@"请输入验证码"];
    }
    
    //验证验证码是否正确
    
    //去往设置密码页面
    InstgramSetPasswordViewController* setPasswordVC = [[InstgramSetPasswordViewController alloc] initWithNibName:nil bundle:nil];
    setPasswordVC.phoneNumber = self.phoneNumber;
    [self.navigationController pushViewController:setPasswordVC animated:YES];
}

- (void)updateSecondsButton:(id)sender
{
    if (_seconds > 0) {
        _seconds --;
        [_secondsButton setTitle:[NSString stringWithFormat:@"%d",_seconds] forState:UIControlStateNormal];
    }else if (_seconds == 0)
    {
        _secondsButton.userInteractionEnabled = YES;
        [_secondsButton setTitle:@"重新获取" forState:UIControlStateNormal];
        [_secondsButton addTarget:self action:@selector(regetMesCode:) forControlEvents:UIControlEventTouchUpInside];
        [_timer invalidate];
    }
}

- (void)regetMesCode:(id)sender
{
    _seconds = 90;
    _secondsButton.userInteractionEnabled = NO;
    [_secondsButton setTitle:[NSString stringWithFormat:@"%d",_seconds] forState:UIControlStateNormal];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateSecondsButton:) userInfo:nil repeats:YES];
}

@end
