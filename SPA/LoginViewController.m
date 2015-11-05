//
//  LoginViewController.m
//  SPA
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "SPALoginSource.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "KMActivityIndicator.h"
#import "CommonReturns.h"
/**
 A Boolean value indicating whether the manager is enabled.
 
 If YES, the manager will change status bar network activity indicator according to network operation notifications it receives. The default value is NO.
 */

#define kConfigScrollviewKey @"121"
#define kConfigEmailTitleLabelKey @"122"
#define kConfigPasswordTitleLabelKey @"124"
#define kConfigEmailTextFiledKey @"123"
#define kConfigPasswordTextFiledKey @"125"
#define kConfigLoginButtonKey @"126"
#define kConfigSignupButtonKey @"127"
#define kConfigForgetPasswordButtonKey @"128"

@interface LoginViewController ()<UIAlertViewDelegate>
{
    __weak id<UIScrollViewDelegate> _scrollViewDelegate;
    __weak id<UITextFieldDelegate> _textFieldDelegate;
    AppDelegate *MainDelegate;
}

@property (nonatomic,retain) UIScrollView *LoginMainBgScrollView;
@property (nonatomic,retain) UILabel *LoginEmailTitleLabel,*LoginPasswordTitleLabel;
@property (nonatomic,retain) UITextField *LoginEmailTextFiled,*LoginPasswordTextFiled;
@property (nonatomic,retain) UIButton *LoginButton,*SignupButton,*ForgetPasswordButton;
@property (nonatomic,retain) MBProgressHUD *ActivityIndicator;
@end

@implementation LoginViewController

#warning remove before goes live
bool isTesting = YES;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Define scrollview
        
        _LoginMainBgScrollView = (UIScrollView *)[self.view viewWithTag:[kConfigScrollviewKey intValue]];
        [_LoginMainBgScrollView setScrollEnabled:YES];
        [_LoginMainBgScrollView setUserInteractionEnabled:YES];
        [_LoginMainBgScrollView setDelegate:_scrollViewDelegate];
        
        // Define UILabel
        
        _LoginEmailTitleLabel       = (UILabel *)[_LoginMainBgScrollView viewWithTag:[kConfigEmailTitleLabelKey intValue]];
        _LoginPasswordTitleLabel    = (UILabel *)[_LoginMainBgScrollView viewWithTag:[kConfigPasswordTitleLabelKey intValue]];
        
        // Define Textfiled
        
        _LoginEmailTextFiled       = (UITextField *)[_LoginMainBgScrollView viewWithTag:[kConfigEmailTextFiledKey intValue]];
        _LoginPasswordTextFiled    = (UITextField *)[_LoginMainBgScrollView viewWithTag:[kConfigPasswordTextFiledKey intValue]];
        
        /**
            Testing Purpose
         **/
        
        if (isTesting) {
            [_LoginEmailTextFiled setText:@"teacher@gmail.com"];
            [_LoginPasswordTextFiled setText:@"#abcd123"];
        }
        
        
        // Define Button
        
        _LoginButton                = (UIButton *)[_LoginMainBgScrollView viewWithTag:[kConfigLoginButtonKey intValue]];
        _SignupButton               = (UIButton *)[_LoginMainBgScrollView viewWithTag:[kConfigSignupButtonKey intValue]];
        _ForgetPasswordButton       = (UIButton *)[_LoginMainBgScrollView viewWithTag:[kConfigForgetPasswordButtonKey intValue]];
        
        MainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
//        _ActivityIndicator = [[KMActivityIndicator alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//        [_ActivityIndicator setCenter:self.view.center];
//        [self.view addSubview:_ActivityIndicator];
        
        // 154.52 -
        
        for (id AllLabel in [_LoginMainBgScrollView subviews]) {
            if ([AllLabel isKindOfClass:[UILabel class]]) {
                UILabel *AllLabelInView = (UILabel *)AllLabel;
                [AllLabelInView setTextColor:Constant.ColorSPABlackColor];
                [AllLabelInView setFont:[UIFont fontWithName:Constant.FontRobotoRegular size:16]];
            }
        }
        
        for (id AllButton in [_LoginMainBgScrollView subviews]) {
            if ([AllButton isKindOfClass:[UIButton class]]) {
                
                UIButton *AllButtonInView = (UIButton *)AllButton;
                
                if (AllButtonInView == _LoginButton)
                    [AllButtonInView addTarget:self action:@selector(ProcessLogin) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _SignupButton)
                    [AllButtonInView addTarget:self action:@selector(GotoSignup) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _ForgetPasswordButton)
                    [AllButtonInView addTarget:self action:@selector(GotoForgetPassword) forControlEvents:UIControlEventTouchUpInside];
                
                [AllButtonInView.titleLabel setTextColor:Constant.ColorSPAWhiteColor];
            }
        }
        
        for (id AllTextFiled in [_LoginMainBgScrollView subviews]) {
            if ([AllTextFiled isKindOfClass:[UITextField class]]) {
                UITextField *AllTextFiledInView = (UITextField *)AllTextFiled;
                [AllTextFiledInView setDelegate:_textFieldDelegate];
                [AllTextFiledInView setBorderStyle:UITextBorderStyleLine];
                
                (AllTextFiledInView.tag == 125)?[AllTextFiledInView setSecureTextEntry:YES]:[AllTextFiledInView setSecureTextEntry:NO];
                
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
    [self CustomizeHeaderwithTitle:@"Login" WithFontName:Constant.FontRobotoBold WithFontSize:32];
    
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
    
    if ([Constant CleanTextField:_LoginEmailTextFiled.text].length == 0) {
        [super ShowAletviewWIthTitle:@"Sorry" Tag:777 Message:@"Email please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if (![Constant ValidateEmail:[Constant CleanTextField:_LoginEmailTextFiled.text]]) {
        [super ShowAletviewWIthTitle:@"Sorry" Tag:778 Message:@"Proper Email please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if ([Constant CleanTextField:_LoginPasswordTextFiled.text].length== 0) {
        [super ShowAletviewWIthTitle:@"Sorry" Tag:779 Message:@"Password please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    }
    return validate;
}

#pragma mark - AlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

#pragma mark - Navigate to different Screen

-(void)ProcessLogin {
    
    if ([self ValidateLoginForm]) {
        
        SPALoginCompletionBlock completionBlock = ^(NSDictionary* data, NSString* errorString) {
            
             NSLog(@"data ==%@ ",data);
            
            [_ActivityIndicator hide:YES];
            if (errorString) {
                if (errorString.length>0) {
                    [super ShowAletviewWIthTitle:@"Sorry" Tag:780 Message:[[errorString substringToIndex:[errorString length] - 2] substringFromIndex:2] CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
                }
            } else {
                //[MainDelegate SetupAfterLoginMenu];
                
                NSString *sessid = [data objectForKey:@"sessid"];
                NSString *session_name = [data objectForKey:@"session_name"];
                NSString *token = [data objectForKey:@"token"];
                
                NSDictionary *userDictionary = [data objectForKey:@"user"];
                
                NSLog(@"userDictionary ==%@ ",userDictionary);
                
                NSString *access = [userDictionary objectForKey:@"access"];
                NSString *created = [userDictionary objectForKey:@"created"];
                
                NSString *field_user_full_name = [self getValueFromDictionary:[userDictionary objectForKey:@"field_user_full_name"]];
                NSString *field_user_keep_logged_in = [self getValueFromDictionary:[userDictionary objectForKey:@"field_user_keep_logged_in"]];
                NSString *field_user_office_hours = [self getValueFromDictionary:[userDictionary objectForKey:@"field_user_office_hours"]];
                NSString *field_user_office_location = [self getValueFromDictionary:[userDictionary objectForKey:@"field_user_office_location"]];
                NSString *field_user_phone = [self getValueFromDictionary:[userDictionary objectForKey:@"field_user_phone"]];
                NSString *field_user_receive_emails = [self getValueFromDictionary:[userDictionary objectForKey:@"field_user_receive_emails"]];
                NSString *field_user_school = [self getValueFromDictionary:[userDictionary objectForKey:@"field_user_school"]];
                
                NSString *language = [userDictionary objectForKey:@"language"];
                NSString *login = [userDictionary objectForKey:@"login"];
                NSString *mail = [userDictionary objectForKey:@"mail"];
                NSString *name = [userDictionary objectForKey:@"name"];
                NSString *signature = [userDictionary objectForKey:@"signature"];
                NSString *signature_format = [userDictionary objectForKey:@"signature_format"];
                NSString *status = [userDictionary objectForKey:@"status"];
                NSString *theme = [userDictionary objectForKey:@"theme"];
                NSString *timezone = [userDictionary objectForKey:@"timezone"];
                NSString *uid = [userDictionary objectForKey:@"uid"];
                NSString *picture = ([[userDictionary objectForKey:@"picture"] isKindOfClass:[NSDictionary class]])?[self getPictureFromDictionary:[userDictionary objectForKey:@"picture"]]:@"";
                NSString *userrole = [self getUserRoleFromDictionary:[userDictionary objectForKey:@"roles"]];
                
                NSArray *FetchedDataArray = [[NSArray alloc] initWithObjects:sessid,session_name,token,access,created,field_user_full_name,field_user_keep_logged_in,field_user_office_hours,field_user_office_location,field_user_phone,field_user_receive_emails,field_user_school,language,login,mail,name,signature,signature_format,status,theme,timezone,uid,picture,userrole, nil];
                
                NSLog(@"FetchedDataArray ==%@ ",FetchedDataArray);
            }
        };
        
        SPALoginSource * source = [SPALoginSource loginDetailsSource];
        [source getLoginDetails:[NSArray arrayWithObjects:[Constant CleanTextField:_LoginEmailTextFiled.text],[Constant CleanTextField:_LoginPasswordTextFiled.text], nil] completion:completionBlock];
        
        _ActivityIndicator = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _ActivityIndicator.mode = MBProgressHUDModeIndeterminate;
        [_ActivityIndicator setOpacity:1.0];
        [_ActivityIndicator show:NO];
        _ActivityIndicator.labelText = @"Loading";
    }
}

-(NSString *)getValueFromDictionary :(NSDictionary *)DataDictionary
{
    NSLog(@"DataDictionary ==>%@",DataDictionary);
    
    NSString *ReturnValue = @"";
    NSArray *Dic = [DataDictionary objectForKey:@"und"];
    if(Dic!=NULL)
        ReturnValue = [[Dic objectAtIndex:0] objectForKey:@"value"];
    return ReturnValue;
}

-(NSString *)getPictureFromDictionary :(NSDictionary *)DataDictionary
{
    if ([DataDictionary count]>0) {
        return (removeNull([DataDictionary objectForKey:@"url"])!=nil)?removeNull([DataDictionary objectForKey:@"url"]):@"";
    } else {
        return @"";
    }
    return @"";
}

-(NSString *)getUserRoleFromDictionary :(NSDictionary *)DataDictionary
{
    NSLog(@"====> %@",DataDictionary);
    
    return nil;
}

-(void)GotoSignup { [self.navigationController pushViewController:Constant.SignupController animated:YES]; }
-(void)GotoForgetPassword { [self.navigationController pushViewController:Constant.ForgetPasswordControllerViewController animated:YES]; }

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

@end
