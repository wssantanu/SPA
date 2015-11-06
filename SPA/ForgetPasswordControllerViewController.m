//
//  ForgetPasswordControllerViewController.m
//  SPA
//
//  Created by Santanu Das Adhikary on 19/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "ForgetPasswordControllerViewController.h"
#import "SPAForgetPasswordSource.h"
#import "AppDelegate.h"
#import "Constant.h"

#define kConfigScrollviewKey @"121"
#define kConfigEmailTitleLabelKey @"122"
#define kConfigPasswordTitleLabelKey @"124"
#define kConfigEmailTextFiledKey @"123"
#define kConfigPasswordTextFiledKey @"125"
#define kConfigLoginButtonKey @"126"
#define kConfigSignupButtonKey @"127"
#define kConfigForgetPasswordButtonKey @"128"

@interface ForgetPasswordControllerViewController ()<UIAlertViewDelegate>
{
    __weak id<UIScrollViewDelegate> _scrollViewDelegate;
    __weak id<UITextFieldDelegate> _textFieldDelegate;
}

@property (nonatomic,retain) UIScrollView *FPMainBgScrollView;
@property (nonatomic,retain) UILabel *FPEmailTitleLabel;
@property (nonatomic,retain) UITextField *FPEmailTextFiled;
@property (nonatomic,retain) UIButton *LoginButton,*SignupButton,*ForgetPasswordButton;
@property (nonatomic,retain) MBProgressHUD *ActivityIndicator;
@end

@implementation ForgetPasswordControllerViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Define scrollview
        
        _FPMainBgScrollView = (UIScrollView *)[self.view viewWithTag:[kConfigScrollviewKey intValue]];
        [_FPMainBgScrollView setScrollEnabled:YES];
        [_FPMainBgScrollView setUserInteractionEnabled:YES];
        [_FPMainBgScrollView setDelegate:_scrollViewDelegate];
        
        // Define UILabel
        
        _FPEmailTitleLabel       = (UILabel *)[_FPMainBgScrollView viewWithTag:[kConfigEmailTitleLabelKey intValue]];
        
        // Define Textfiled
        
        _FPEmailTextFiled       = (UITextField *)[_FPMainBgScrollView viewWithTag:[kConfigEmailTextFiledKey intValue]];
        
        // Define Button
        
        _LoginButton                = (UIButton *)[_FPMainBgScrollView viewWithTag:[kConfigLoginButtonKey intValue]];
        _SignupButton               = (UIButton *)[_FPMainBgScrollView viewWithTag:[kConfigSignupButtonKey intValue]];
        _ForgetPasswordButton       = (UIButton *)[_FPMainBgScrollView viewWithTag:[kConfigForgetPasswordButtonKey intValue]];
        
        for (id AllLabel in [_FPMainBgScrollView subviews]) {
            if ([AllLabel isKindOfClass:[UILabel class]]) {
                UILabel *AllLabelInView = (UILabel *)AllLabel;
                [AllLabelInView setTextColor:Constant.ColorSPABlackColor];
                [AllLabelInView setFont:[UIFont fontWithName:Constant.FontRobotoRegular size:16]];
            }
        }
        
        for (id AllButton in [_FPMainBgScrollView subviews]) {
            if ([AllButton isKindOfClass:[UIButton class]]) {
                
                UIButton *AllButtonInView = (UIButton *)AllButton;
                
                if (AllButtonInView == _LoginButton)
                    [AllButtonInView addTarget:self action:@selector(ProcessRecoverPassword) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _SignupButton)
                    [AllButtonInView addTarget:self action:@selector(CancelOperation) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _ForgetPasswordButton)
                    [AllButtonInView addTarget:self action:@selector(GotoLogin) forControlEvents:UIControlEventTouchUpInside];
                
                [AllButtonInView.titleLabel setTextColor:Constant.ColorSPAWhiteColor];
            }
        }
        
        for (id AllTextFiled in [_FPMainBgScrollView subviews]) {
            if ([AllTextFiled isKindOfClass:[UITextField class]]) {
                UITextField *AllTextFiledInView = (UITextField *)AllTextFiled;
                [AllTextFiledInView setDelegate:_textFieldDelegate];
                [AllTextFiledInView setBorderStyle:UITextBorderStyleLine];
                
                UIView *LefftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, AllTextFiledInView.frame.size.height)];
                [LefftView setBackgroundColor:[UIColor clearColor]];
                [AllTextFiledInView setLeftView:LefftView];
                [AllTextFiledInView setLeftViewMode:UITextFieldViewModeAlways];
            }
        }
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view setBackgroundColor:Constant.ColorSPAWhiteColor];
    
    [self CustomizeHeaderwithTitle:@"Request password" WithFontName:Constant.FontRobotoBold WithFontSize:32];
}

-(void)CustomizeHeaderwithTitle:(NSString *)Title WithFontName:(NSString *)FontName WithFontSize:(float)Size
{
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, HeaderHeight)];
    [HeaderView setBackgroundColor:Constant.ColorSPAYellowColor];
    HeaderView.layer.masksToBounds = NO;
    HeaderView.layer.shadowOffset = CGSizeMake(0, 1);
    HeaderView.layer.shadowRadius = 10;
    HeaderView.layer.shadowOpacity = 0.4;
    HeaderView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:HeaderView];
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, HeaderView.layer.frame.size.width-20, HeaderView.layer.frame.size.height-10)];
    [TitleLabel setBackgroundColor:[UIColor clearColor]];
    [TitleLabel setTextColor:Constant.ColorSPAWhiteColor];
    [TitleLabel setText:Title];
    [TitleLabel setTextAlignment:NSTextAlignmentCenter];
    [TitleLabel setFont:[UIFont fontWithName:FontName size:Size]];
    [HeaderView addSubview:TitleLabel];
}


#pragma mark - Vaidate Login Form

-(BOOL)ValidateLoginForm
{
    BOOL validate = YES;
    
    if ([Constant CleanTextField:_FPEmailTextFiled.text].length == 0) {
        [super ShowAletviewWIthTitle:@"Sorry" Tag:777 Message:@"Email please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if (![Constant ValidateEmail:[Constant CleanTextField:_FPEmailTextFiled.text]]) {
        [super ShowAletviewWIthTitle:@"Sorry" Tag:778 Message:@"Proper Email please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    }
    return validate;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [_FPEmailTextFiled setText:@""];
    if (alertView.tag == 782)
        [self CancelOperation];
}

#pragma mark - Navigate to different Screen

-(void)ProcessRecoverPassword {
    if ([self ValidateLoginForm]) {
        SPAForgetPasswordCompletionBlock completionBlock = ^(NSDictionary* data, NSString* errorString) {
            
            [_ActivityIndicator hide:YES];
            if (errorString) {
                if (errorString.length>0) {
                    [super ShowAletviewWIthTitle:@"Sorry" Tag:780 Message:[[errorString substringToIndex:[errorString length] - 2] substringFromIndex:2] CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
                }
            } else {
                if ([[data objectForKey:@"error"] intValue] == 1) {
                     [super ShowAletviewWIthTitle:@"Sorry" Tag:781 Message:[data objectForKey:@"message"] CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
                } else {
                     [super ShowAletviewWIthTitle:@"Success" Tag:782 Message:[data objectForKey:@"message"] CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
                }
            }
        };
        
        SPAForgetPasswordSource * source = [SPAForgetPasswordSource ForgetPasswordDetailsSource];
        [source getForgetPasswordDetails:[NSArray arrayWithObjects:[Constant CleanTextField:_FPEmailTextFiled.text], nil] completion:completionBlock];
        
        _ActivityIndicator = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _ActivityIndicator.mode = MBProgressHUDModeIndeterminate;
        [_ActivityIndicator setOpacity:1.0];
        [_ActivityIndicator show:NO];
        _ActivityIndicator.labelText = @"Loading";
    }
}
-(void)GotoLogin { [self.navigationController pushViewController:Constant.LoginViewController animated:YES]; }
-(void)CancelOperation { [self.navigationController popViewControllerAnimated:YES];}
#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

@end
