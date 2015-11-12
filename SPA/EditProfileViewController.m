//
//  EditProfileViewController.m
//  SPA
//
//  Created by Santanu Das Adhikary on 03/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "EditProfileViewController.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "PECropViewController.h"
#import "DataModel.h"
#import "UserDetails.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SPAChangePasswordSource.h"
#import "SPAEditTeacherProfileSource.h"
#import "SPAEditStudentProfileSource.h"

#define kConfigScrollviewKey @"121"
#define kConfigTeacherEmailTextfieldKey @"123"
#define kConfigTeacherNameTextfieldKey @"124"
#define kConfigTeacherPasswordTextfieldKey @"125"
#define kConfigTeacherConfirmPasswordTextfieldKey @"126"
#define kConfigTeacherSchoolTextfieldKey @"127"
#define kConfigTeacherOfficeLocationTextfieldKey @"128"
#define kConfigTeacherOfficeHoursTextfieldKey @"129"
#define kConfigTeacherPhoneTextfieldKey @"130"

#define kConfigStudentEmailTextfieldKey @"223"
#define kConfigStudentNameTextfieldKey @"224"
#define kConfigStudentPasswordTextfieldKey @"225"
#define kConfigStudentConfirmPasswordTextfieldKey @"226"

#define kConfigTeacherTypeButtonKey @"999"
#define kConfigStudentTypeButtonKey @"888"

#define kConfigTeacherReceiveEmailTypeButtonKey @"1123"
#define kConfigTeacherLoginDeviceTypeButtonKey @"1124"
#define kConfigStudentReceiveEmailTypeButtonKey @"2123"
#define kConfigStudentLoginDeviceTypeButtonKey @"2124"

#define kConfigCheckboxNormalKey @"checkbox_normal"
#define kConfigCheckboxSelectedKey @"checkbox_selected"
#define kConfigRedioButtonNormalKey @"rediobutton_unchacked"
#define kConfigRedioButtonSelectedKey @"rediobutton_chacked"

//#define kConfigTeacherTypeCancelButtonKey @"6213"
#define kConfigTeacherTypeSaveButtonKey @"6214"
#define kConfigTeacherTypeCancelButtonKey @"6215"
#define kConfigStudentTypeSaveButtonKey @"7213"
//#define kConfigStudentTypeRegistrationButtonKey @"7214"
#define kConfigStudentTypeCancelButtonKey @"7215"

#define kConfigAttachedViewYPosition @"0"

#define kConfigSendEmailYes @"1"
#define kConfigSendEmailNo @"0"
#define kConfigLoginDeviceYes @"1"
#define kConfigLoginDeviceNo @"0"
#define kConfiguserTypeTeacher @"4"
#define kConfiguserTypeStudent @"5"

#define kConfigEditProfileOldPassword @"6543"
#define kConfigEditProfileNewPassword @"6542"
#define kConfigEditProfileConfirmPassword @"6541"
#define kConfigEditProfileSaveButton @"6540"

typedef enum {
    userTypeTeacher,
    userTypeStudent
} userType;

typedef enum {
    changePasswordisVisiable,
    changePasswordisinVisiable
} changePasswordVisiabelity;

typedef enum {
    receiveEmailNo,
    receiveEmailYes
} receiveEmail;

typedef enum {
    loginDeviceNo,
    loginDeviceYes
} loginDevice;

typedef enum {
    dataSaveOptionNone,
    dataSaveOptionEditProfile,
    dataSaveOptionChangePassword
} dataSaveOption;


@interface EditProfileViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, PECropViewControllerDelegate,UIAlertViewDelegate>{
    __weak id<UIScrollViewDelegate> _scrollViewDelegate;
    __weak id<UITextFieldDelegate> _textFieldDelegate;
    UserDetails *FeatchUserdetails;
}
@property (nonatomic,retain) UIScrollView *LoginMainBgScrollView;
@property (nonatomic,retain) UILabel *LoginEmailTitleLabel,*LoginPasswordTitleLabel;
@property (nonatomic,retain) IBOutlet UIView *TeacherTypeView,*StudentTypeView,*ForgetPasswordView,*TransparentView;
@property (nonatomic) UIPopoverController *popover;
@property (nonatomic, weak) IBOutlet UIButton *editButton;
@property (nonatomic, weak) IBOutlet UIImageView *imageView,*imageViewOne;
@property (nonatomic, weak) IBOutlet UIButton *cameraButton,*ChangePasswordButtonStudentView,*ChangePasswordButtonTeacherView;
@property (nonatomic,retain) IBOutlet UIButton *FPCancelButton,*FPSaveButton;
@property (assign) changePasswordVisiabelity changePasswordVisiabelityType;
@property (assign) userType SelectedUserType;
@property (assign) receiveEmail receiveEmailType;
@property (assign) loginDevice  loginDeviceType;
@property (assign) dataSaveOption  DataSaveOption;
@property (nonatomic,retain) MBProgressHUD *ActivityIndicator;
@property (nonatomic, strong) NSArray * dataSourceTeacher,*dataSourceStudent;

@property (nonatomic,retain) IBOutlet UIButton *EPTeacherCancelButton,*EPStudentCancelButton,*EPTeacherSaveButton,*EPStudentSaveButton;

@property (nonatomic,retain) UIButton *LoginButton,*SignupButton,*ForgetPasswordButton,*TeacherTypeButton,*StudentTypeButton,*TeacherReceiveEmailButton,*TeacherLogedinDeviceButton,*StudentReceiveEmailButton,*StudentLogedinDeviceButton,*TeacherLoginButton,*TeacherSignupButton,*TeacherForgetPasswordButton,*StudentLoginButton,*StudentSignupButton,*StudentForgetPasswordButton,*ForgetPasswordSaveButton;

@property (nonatomic,retain) UITextField *TeacherEmailTextfield,*TeacherNameTextfield,*TeacherPasswordTextfield,*TeacherConfirmPasswordTextfield,*TeacherSchoolTextfield,*TeacherOfficeLocationTextfield,*TeacherOfficeHoursTextfield,*TeacherPhoneTextfield,*StudentEmailTextfield,*StudentNameTextfield,*StudentPasswordTextfield,*StudentConfirmPasswordTextfield,*LoginEmailTextFiled,*LoginPasswordTextFiled,*EditPasswordOldPassword,*EditPasswordNewPassword,*EditPasswordCOnfirmPassword;

@end

@implementation EditProfileViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Define scrollview
        
        _changePasswordVisiabelityType = changePasswordisinVisiable;
        _DataSaveOption = dataSaveOptionNone;
        
        DataModel *dataModelObj = [DataModel sharedEngine];
        
        FeatchUserdetails = [dataModelObj fetchCurrentUser];
        
        if ([FeatchUserdetails.roles isEqualToString:@"4"]) {
            _SelectedUserType = userTypeTeacher;
        } else if ([FeatchUserdetails.roles isEqualToString:@"5"]) {
            _SelectedUserType = userTypeStudent;
        }
        
        _dataSourceTeacher = [[NSArray alloc] initWithObjects:FeatchUserdetails.user_full_name,FeatchUserdetails.mail,FeatchUserdetails.user_school,FeatchUserdetails.user_office_location,FeatchUserdetails.user_office_hours,FeatchUserdetails.user_phone,FeatchUserdetails.picture,FeatchUserdetails.user_receive_emails,FeatchUserdetails.keep_logged_in, nil];
        
        _dataSourceStudent = [[NSArray alloc] initWithObjects:FeatchUserdetails.user_full_name,FeatchUserdetails.mail,FeatchUserdetails.picture,FeatchUserdetails.user_receive_emails,FeatchUserdetails.keep_logged_in, nil];
        
        _LoginMainBgScrollView = (UIScrollView *)[self.view viewWithTag:[kConfigScrollviewKey intValue]];
        [_LoginMainBgScrollView setScrollEnabled:YES];
        [_LoginMainBgScrollView setUserInteractionEnabled:YES];
        [_LoginMainBgScrollView setShowsHorizontalScrollIndicator:NO];
        [_LoginMainBgScrollView setShowsVerticalScrollIndicator:NO];
        [_LoginMainBgScrollView setDelegate:_scrollViewDelegate];
        
        _TeacherEmailTextfield              = (UITextField *)[_TeacherTypeView viewWithTag:[kConfigTeacherEmailTextfieldKey intValue]];
        
        [_TeacherEmailTextfield setText:FeatchUserdetails.mail];
        
        _TeacherNameTextfield               = (UITextField *)[_TeacherTypeView viewWithTag:[kConfigTeacherNameTextfieldKey intValue]];
        [_TeacherNameTextfield setText:FeatchUserdetails.user_full_name];
        
        _TeacherPasswordTextfield           = (UITextField *)[_TeacherTypeView viewWithTag:[kConfigTeacherPasswordTextfieldKey intValue]];
        [_TeacherPasswordTextfield setText:FeatchUserdetails.user_full_name];
        
        _TeacherSchoolTextfield             = (UITextField *)[_TeacherTypeView viewWithTag:[kConfigTeacherSchoolTextfieldKey intValue]];
        [_TeacherSchoolTextfield setText:FeatchUserdetails.user_school];
        
        _TeacherOfficeLocationTextfield     = (UITextField *)[_TeacherTypeView viewWithTag:[kConfigTeacherOfficeLocationTextfieldKey intValue]];
        [_TeacherOfficeLocationTextfield setText:FeatchUserdetails.user_office_location];
        
        _TeacherOfficeHoursTextfield        = (UITextField *)[_TeacherTypeView viewWithTag:[kConfigTeacherOfficeHoursTextfieldKey intValue]];
        [_TeacherOfficeHoursTextfield setText:FeatchUserdetails.user_office_hours];
        
        NSLog(@"FeatchUserdetails ==>%@ ==>%@",FeatchUserdetails.token,FeatchUserdetails.uid);
        
        _TeacherPhoneTextfield              = (UITextField *)[_TeacherTypeView viewWithTag:[kConfigTeacherPhoneTextfieldKey intValue]];
        [_TeacherPhoneTextfield setText:FeatchUserdetails.user_phone];
        
        _StudentEmailTextfield              = (UITextField *)[_StudentTypeView viewWithTag:[kConfigStudentEmailTextfieldKey intValue]];
        _StudentNameTextfield               = (UITextField *)[_StudentTypeView viewWithTag:[kConfigStudentNameTextfieldKey intValue]];
        _StudentPasswordTextfield           = (UITextField *)[_StudentTypeView viewWithTag:[kConfigStudentPasswordTextfieldKey intValue]];
        _StudentConfirmPasswordTextfield    = (UITextField *)[_StudentTypeView viewWithTag:[kConfigStudentConfirmPasswordTextfieldKey intValue]];
        
//        _TeacherTypeButton                  = (UIButton *)[_LoginMainBgScrollView viewWithTag:[kConfigTeacherTypeButtonKey intValue]];
//        _StudentTypeButton                  = (UIButton *)[_LoginMainBgScrollView viewWithTag:[kConfigStudentTypeButtonKey intValue]];
        
        _TeacherLoginButton                 = (UIButton *)[_TeacherTypeView viewWithTag:[kConfigTeacherTypeSaveButtonKey intValue]];
        [_TeacherLoginButton.titleLabel setText:@"C"];
        _TeacherForgetPasswordButton        = (UIButton *)[_TeacherTypeView viewWithTag:[kConfigTeacherTypeCancelButtonKey intValue]];
        [_TeacherForgetPasswordButton.titleLabel setText:@"D"];
        //NSLog(@"_Teacher All Button => %ld // %ld",(long)_TeacherLoginButton.tag,(long)_TeacherForgetPasswordButton.tag);
        
        _TeacherReceiveEmailButton          = (UIButton *)[_TeacherTypeView viewWithTag:[kConfigTeacherReceiveEmailTypeButtonKey intValue]];
        _TeacherLogedinDeviceButton         = (UIButton *)[_TeacherTypeView viewWithTag:[kConfigTeacherLoginDeviceTypeButtonKey intValue]];
        
        _StudentLoginButton                 = (UIButton *)[_StudentTypeView viewWithTag:[kConfigStudentTypeSaveButtonKey intValue]];
        _StudentForgetPasswordButton        = (UIButton *)[_StudentTypeView viewWithTag:[kConfigStudentTypeCancelButtonKey intValue]];
        
        _StudentReceiveEmailButton          = (UIButton *)[_StudentTypeView viewWithTag:[kConfigStudentReceiveEmailTypeButtonKey intValue]];
        _StudentLogedinDeviceButton         = (UIButton *)[_StudentTypeView viewWithTag:[kConfigStudentLoginDeviceTypeButtonKey intValue]];
        
        [(_SelectedUserType == userTypeTeacher)?_imageViewOne:_imageView setImage:[UIImage imageNamed:@"menu_profile_selected"]];
        (_SelectedUserType == userTypeTeacher)?[_imageViewOne.layer setCornerRadius:40.0f]:[_imageView.layer setCornerRadius:40.0f];
        (_SelectedUserType == userTypeTeacher)?[_imageViewOne.layer setBorderWidth:3.0f]:[_imageView.layer setBorderWidth:3.0f];
        [(_SelectedUserType == userTypeTeacher)?_imageViewOne:_imageView setClipsToBounds:YES];
        (_SelectedUserType == userTypeTeacher)?[_imageViewOne.layer setBorderColor:[UIColor lightGrayColor].CGColor]:[_imageView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        
        if (FeatchUserdetails.picture.length > 0) {
            [(_SelectedUserType == userTypeTeacher)?_imageViewOne:_imageView sd_setImageWithURL:[NSURL URLWithString:FeatchUserdetails.picture] placeholderImage:[UIImage imageNamed:@"menu_profile_selected"]];
        } else {
            [(_SelectedUserType == userTypeTeacher)?_imageViewOne:_imageView sd_setImageWithURL:[NSURL URLWithString:@"http://studentplanner.dev.webspiders.com/sites/all/themes/studentplanner/images/profile-img.jpg"] placeholderImage:[UIImage imageNamed:@"menu_profile_selected"]];
        }
        
        if ([FeatchUserdetails.user_receive_emails isEqualToString:@"1"]) {
            [(_SelectedUserType == userTypeTeacher)?_TeacherReceiveEmailButton:_StudentReceiveEmailButton setImage:[UIImage imageNamed:kConfigCheckboxSelectedKey] forState:UIControlStateNormal];
            _receiveEmailType = receiveEmailYes;
        } else {
            [(_SelectedUserType == userTypeTeacher)?_TeacherReceiveEmailButton:_StudentReceiveEmailButton setImage:[UIImage imageNamed:kConfigCheckboxNormalKey] forState:UIControlStateNormal];
            _receiveEmailType = receiveEmailNo;
        }
        
        if ([FeatchUserdetails.keep_logged_in isEqualToString:@"1"]) {
            [(_SelectedUserType == userTypeTeacher)?_TeacherLogedinDeviceButton:_StudentLogedinDeviceButton setImage:[UIImage imageNamed:kConfigCheckboxSelectedKey] forState:UIControlStateNormal];
            _loginDeviceType = loginDeviceYes;
        } else {
            [(_SelectedUserType == userTypeTeacher)?_TeacherLogedinDeviceButton:_StudentLogedinDeviceButton setImage:[UIImage imageNamed:kConfigCheckboxNormalKey] forState:UIControlStateNormal];
            _loginDeviceType = loginDeviceNo;
        }
        
        _TransparentView = [[UIView alloc] initWithFrame:self.view.frame];
        [_TransparentView setBackgroundColor:Constant.ColorSPABlackColor];
        [_TransparentView.layer setOpacity:0.6];
        
        [_ChangePasswordButtonStudentView addTarget:self action:@selector(OpenChangePasswordButton) forControlEvents:UIControlEventTouchUpInside];
        [_ChangePasswordButtonTeacherView addTarget:self action:@selector(OpenChangePasswordButton) forControlEvents:UIControlEventTouchUpInside];
        
        [_FPSaveButton addTarget:self action:@selector(SaveForgetPassword) forControlEvents:UIControlEventTouchUpInside];
        [_FPCancelButton addTarget:self action:@selector(OpenChangePasswordButton) forControlEvents:UIControlEventTouchUpInside];
        
        /**
         Forget password section
         */
        
        _ForgetPasswordSaveButton = (UIButton *)[_ForgetPasswordView viewWithTag:[kConfigEditProfileSaveButton intValue]];
        [_ForgetPasswordSaveButton addTarget:self action:@selector(doEditPassword) forControlEvents:UIControlEventTouchUpInside];
        
        _EditPasswordOldPassword = (UITextField *)[_ForgetPasswordView viewWithTag:[kConfigEditProfileOldPassword intValue]];
        _EditPasswordNewPassword = (UITextField *)[_ForgetPasswordView viewWithTag:[kConfigEditProfileNewPassword intValue]];
        _EditPasswordCOnfirmPassword = (UITextField *)[_ForgetPasswordView viewWithTag:[kConfigEditProfileConfirmPassword intValue]];
        
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
                
                if (AllButtonInView == _TeacherTypeButton)
                {
                    [AllButtonInView addTarget:self action:@selector(UserTypeSelect:) forControlEvents:UIControlEventTouchUpInside];
                }
                else if (AllButtonInView == _StudentTypeButton) {
                    [AllButtonInView addTarget:self action:@selector(UserTypeSelect:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }
        
        for (id AllTextFiled in [_LoginMainBgScrollView subviews]) {
            if ([AllTextFiled isKindOfClass:[UITextField class]]) {
                UITextField *AllTextFiledInView = (UITextField *)AllTextFiled;
                [AllTextFiledInView setDelegate:_textFieldDelegate];
                [AllTextFiledInView setBorderStyle:UITextBorderStyleLine];
            }
        }
        
        // Teacher Type View
        
        for (id AllLabel in [_TeacherTypeView subviews]) {
            if ([AllLabel isKindOfClass:[UILabel class]]) {
                UILabel *AllLabelInView = (UILabel *)AllLabel;
                [AllLabelInView setTextColor:Constant.ColorSPABlackColor];
                [AllLabelInView setFont:[UIFont fontWithName:Constant.FontRobotoRegular size:16]];
            }
        }
        
        for (id AllButton in [_TeacherTypeView subviews]) {
            if ([AllButton isKindOfClass:[UIButton class]]) {
                
                UIButton *AllButtonInView = (UIButton *)AllButton;
                
                /**if (AllButtonInView == _TeacherLoginButton)
                {
                    NSLog(@"_TeacherLoginButton tag ==> %ld",_TeacherLoginButton.tag);
                    [AllButtonInView addTarget:self action:@selector(saveEditedData) forControlEvents:UIControlEventTouchUpInside];
                }
                else if (AllButtonInView == _TeacherForgetPasswordButton)
                {
                    [AllButtonInView addTarget:self action:@selector(CencelEditOption) forControlEvents:UIControlEventTouchUpInside];
                }
                 **/
                if (AllButtonInView == _TeacherReceiveEmailButton)
                    [AllButtonInView addTarget:self action:@selector(changeSettings:) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _TeacherLogedinDeviceButton)
                    [AllButtonInView addTarget:self action:@selector(changeSettings:) forControlEvents:UIControlEventTouchUpInside];
                
                [AllButtonInView setUserInteractionEnabled:YES];
                [AllButtonInView.titleLabel setTextColor:Constant.ColorSPAWhiteColor];
            }
        }
        
        for (id AllTextFiled in [_TeacherTypeView subviews]) {
            if ([AllTextFiled isKindOfClass:[UITextField class]]) {
                UITextField *AllTextFiledInView = (UITextField *)AllTextFiled;
                [AllTextFiledInView setDelegate:_textFieldDelegate];
                [AllTextFiledInView setBorderStyle:UITextBorderStyleLine];
                
                UIView *LefftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, AllTextFiledInView.frame.size.height)];
                [LefftView setBackgroundColor:[UIColor clearColor]];
                [AllTextFiledInView setLeftView:LefftView];
                [AllTextFiledInView setLeftViewMode:UITextFieldViewModeAlways];
                
                if (AllTextFiledInView == _TeacherPasswordTextfield || AllTextFiledInView == _TeacherConfirmPasswordTextfield) {
                    [AllTextFiledInView setSecureTextEntry:YES];
                }
            }
        }
        
        //
        
        for (id AllTextFiled in [_ForgetPasswordView subviews]) {
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
        
        // Student Type View
        
        for (id AllLabel in [_StudentTypeView subviews]) {
            if ([AllLabel isKindOfClass:[UILabel class]]) {
                UILabel *AllLabelInView = (UILabel *)AllLabel;
                [AllLabelInView setTextColor:Constant.ColorSPABlackColor];
                [AllLabelInView setFont:[UIFont fontWithName:Constant.FontRobotoRegular size:16]];
            }
        }
        
        for (id AllButton in [_StudentTypeView subviews]) {
            if ([AllButton isKindOfClass:[UIButton class]]) {
                
                UIButton *AllButtonInView = (UIButton *)AllButton;
                
                if (AllButtonInView == _StudentLoginButton)
                    [AllButtonInView addTarget:self action:@selector(saveEditedData) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _StudentSignupButton)
                    [AllButtonInView addTarget:self action:@selector(GotoSignup) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _StudentReceiveEmailButton)
                    [AllButtonInView addTarget:self action:@selector(changeSettings:) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _StudentLogedinDeviceButton)
                    [AllButtonInView addTarget:self action:@selector(changeSettings:) forControlEvents:UIControlEventTouchUpInside];
                
                [AllButtonInView.titleLabel setTextColor:Constant.ColorSPAWhiteColor];
            }
        }
        
        for (id AllTextFiled in [_StudentTypeView subviews]) {
            if ([AllTextFiled isKindOfClass:[UITextField class]]) {
                UITextField *AllTextFiledInView = (UITextField *)AllTextFiled;
                [AllTextFiledInView setDelegate:_textFieldDelegate];
                [AllTextFiledInView setBorderStyle:UITextBorderStyleLine];
                
                UIView *LefftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, AllTextFiledInView.frame.size.height)];
                [LefftView setBackgroundColor:[UIColor clearColor]];
                [AllTextFiledInView setLeftView:LefftView];
                [AllTextFiledInView setLeftViewMode:UITextFieldViewModeAlways];
                
                if (AllTextFiledInView == _StudentPasswordTextfield || AllTextFiledInView == _StudentConfirmPasswordTextfield) {
                    [AllTextFiledInView setSecureTextEntry:YES];
                }
            }
        }
        
        [_EPTeacherCancelButton addTarget:self action:@selector(GotoViewProfile) forControlEvents:UIControlEventTouchUpInside];
        [_EPStudentCancelButton addTarget:self action:@selector(GotoViewProfile) forControlEvents:UIControlEventTouchUpInside];
        
        [_EPTeacherSaveButton addTarget:self action:@selector(doEditData) forControlEvents:UIControlEventTouchUpInside];
        [_EPStudentSaveButton addTarget:self action:@selector(doEditData) forControlEvents:UIControlEventTouchUpInside];
        
        [self UserTypeChanged];
    }
    return self;
}

-(NSString *)getUserType {
    return (_SelectedUserType == userTypeTeacher)?kConfiguserTypeTeacher:kConfiguserTypeStudent;
}
-(NSString *)getEmailReciveStatus {
    return (_receiveEmailType == receiveEmailNo)?kConfigSendEmailNo:kConfigSendEmailYes;
}
-(NSString *)getLoginDeviceStatus {
    return (_loginDeviceType == loginDeviceNo)?kConfigLoginDeviceNo:kConfigLoginDeviceYes;
}
-(void)doEditPassword {
    if ([self ValidateEditPasswordForm]) {
        _DataSaveOption = dataSaveOptionChangePassword;
        [self ProcessSaveData];
    }
}
-(void)doEditData {
    
    _DataSaveOption = dataSaveOptionEditProfile;
    [self ProcessSaveData];
}

-(void)changeSettings :(UIButton *)sender
{
    if (_SelectedUserType == userTypeTeacher) {
        if (sender.tag == [kConfigTeacherReceiveEmailTypeButtonKey intValue]) {
            if (_receiveEmailType == receiveEmailNo) {
                [_TeacherReceiveEmailButton setImage:[UIImage imageNamed:kConfigCheckboxSelectedKey] forState:UIControlStateNormal];
                [_TeacherReceiveEmailButton setImage:[UIImage imageNamed:kConfigCheckboxSelectedKey] forState:UIControlStateNormal];
                _receiveEmailType = receiveEmailYes;
            } else {
                [_TeacherReceiveEmailButton setImage:[UIImage imageNamed:kConfigCheckboxNormalKey] forState:UIControlStateNormal];
                [_TeacherReceiveEmailButton setImage:[UIImage imageNamed:kConfigCheckboxNormalKey] forState:UIControlStateNormal];
                _receiveEmailType = receiveEmailNo;
            }
        }
        else if (sender.tag == [kConfigTeacherLoginDeviceTypeButtonKey intValue]) {
            if (_loginDeviceType == loginDeviceNo) {
                [_TeacherLogedinDeviceButton setImage:[UIImage imageNamed:kConfigCheckboxSelectedKey] forState:UIControlStateNormal];
                [_TeacherLogedinDeviceButton setImage:[UIImage imageNamed:kConfigCheckboxSelectedKey] forState:UIControlStateNormal];
                _loginDeviceType = loginDeviceYes;
            } else {
                [_TeacherLogedinDeviceButton setImage:[UIImage imageNamed:kConfigCheckboxNormalKey] forState:UIControlStateNormal];
                [_TeacherLogedinDeviceButton setImage:[UIImage imageNamed:kConfigCheckboxNormalKey] forState:UIControlStateNormal];
                _loginDeviceType = loginDeviceNo;
            }
        }
    }
    else if (_SelectedUserType == userTypeStudent) {
        if (sender.tag == [kConfigStudentReceiveEmailTypeButtonKey intValue]) {
            if (_receiveEmailType == receiveEmailNo) {
                [_StudentReceiveEmailButton setImage:[UIImage imageNamed:kConfigCheckboxSelectedKey] forState:UIControlStateNormal];
                [_StudentReceiveEmailButton setImage:[UIImage imageNamed:kConfigCheckboxSelectedKey] forState:UIControlStateNormal];
                _receiveEmailType = receiveEmailYes;
            } else {
                [_StudentReceiveEmailButton setImage:[UIImage imageNamed:kConfigCheckboxNormalKey] forState:UIControlStateNormal];
                [_StudentReceiveEmailButton setImage:[UIImage imageNamed:kConfigCheckboxNormalKey] forState:UIControlStateNormal];
                _receiveEmailType = receiveEmailNo;
            }
        }
        else if (sender.tag == [kConfigStudentLoginDeviceTypeButtonKey intValue]) {
            if (_loginDeviceType == loginDeviceNo) {
                [_StudentLogedinDeviceButton setImage:[UIImage imageNamed:kConfigCheckboxSelectedKey] forState:UIControlStateNormal];
                [_StudentLogedinDeviceButton setImage:[UIImage imageNamed:kConfigCheckboxSelectedKey] forState:UIControlStateNormal];
                _loginDeviceType = loginDeviceYes;
            } else {
                [_StudentLogedinDeviceButton setImage:[UIImage imageNamed:kConfigCheckboxNormalKey] forState:UIControlStateNormal];
                [_StudentLogedinDeviceButton setImage:[UIImage imageNamed:kConfigCheckboxNormalKey] forState:UIControlStateNormal];
                _loginDeviceType = loginDeviceNo;
            }
        }
    }
}

-(void)OpenChangePasswordButton
{
    AppDelegate *MainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    for (id AllTextFiled in [_ForgetPasswordView subviews]) {
        if ([AllTextFiled isKindOfClass:[UITextField class]]) {
            UITextField *AllTextFiledInView = (UITextField *)AllTextFiled;
            [AllTextFiledInView setDelegate:_textFieldDelegate];
            [AllTextFiledInView setBorderStyle:UITextBorderStyleLine];
            [AllTextFiledInView setText:nil];
        }
    }
    
    [_ForgetPasswordView setFrame:CGRectMake(10, 100, self.view.frame.size.width-20, _ForgetPasswordView.frame.size.height)];
    
    if ( _changePasswordVisiabelityType == changePasswordisinVisiable) {
        
        _ForgetPasswordView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        
        [MainDelegate.window addSubview:_TransparentView];
        [MainDelegate.window addSubview:_ForgetPasswordView];
        
        [UIView animateWithDuration:0.3/1.5 animations:^{
            _ForgetPasswordView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                _ForgetPasswordView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3/2 animations:^{
                    _ForgetPasswordView.transform = CGAffineTransformIdentity;
                }];
            }];
        }];
        
        _changePasswordVisiabelityType = changePasswordisVisiable;
        
    } else if(_changePasswordVisiabelityType == changePasswordisVisiable){
        
        _ForgetPasswordView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        
        [UIView animateWithDuration:0.3/1.5 animations:^{
            _ForgetPasswordView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                _ForgetPasswordView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3/2 animations:^{
                    _ForgetPasswordView.transform = CGAffineTransformIdentity;
                }];
                [_TransparentView removeFromSuperview];
                [_ForgetPasswordView removeFromSuperview];
            }];
        }];
        
        _changePasswordVisiabelityType = changePasswordisinVisiable;
    }
}

#pragma mark - PECropViewControllerDelegate methods

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage transform:(CGAffineTransform)transform cropRect:(CGRect)cropRect
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    
    if (_SelectedUserType == userTypeTeacher) {
        self.imageViewOne.image = croppedImage;
    } else {
        self.imageView.image = croppedImage;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self updateEditButtonEnabled];
    }
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self updateEditButtonEnabled];
    }
    
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Action methods

- (IBAction)openEditor:(id)sender
{
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.rotationEnabled = NO;
    controller.keepingCropAspectRatio = YES;
    controller.cropAspectRatio = 9.0f / 9.0f;
    controller.image = (_SelectedUserType == userTypeTeacher)?self.imageViewOne.image:self.imageView.image;
    
    UIImage *image = (_SelectedUserType == userTypeTeacher)?self.imageViewOne.image:self.imageView.image;//self.imageView.image;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat length = MIN(width, height);
    controller.imageCropRect = CGRectMake((width - length) / 2,(height - length) / 2,length,length);
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [self presentViewController:navigationController animated:YES completion:NULL];
}

- (IBAction)cameraButtonAction:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"Photo Album", nil), nil];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [actionSheet addButtonWithTitle:NSLocalizedString(@"Camera", nil)];
    }
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", nil)];
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [actionSheet showFromBarButtonItem:self.cameraButton animated:YES];
    } else {
        [actionSheet showFromToolbar:self.navigationController.toolbar];
    }
}

#pragma mark - Private methods

- (void)showCamera
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        
        self.popover = [[UIPopoverController alloc] initWithContentViewController:controller];
        [self.popover presentPopoverFromBarButtonItem:self.cameraButton
                             permittedArrowDirections:UIPopoverArrowDirectionAny
                                             animated:YES];
    } else {
        [self presentViewController:controller animated:YES completion:NULL];
    }
}

- (void)openPhotoAlbum
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        
        self.popover = [[UIPopoverController alloc] initWithContentViewController:controller];
        [self.popover presentPopoverFromBarButtonItem:self.cameraButton
                             permittedArrowDirections:UIPopoverArrowDirectionAny
                                             animated:YES];
    } else {
        [self presentViewController:controller animated:YES completion:NULL];
    }
}

- (void)updateEditButtonEnabled
{
    self.editButton.enabled = !!(_SelectedUserType == userTypeTeacher)?self.imageViewOne.image:self.imageView.image;
}

#pragma mark - UIActionSheetDelegate methods

/*
 Open camera or photo album.
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:NSLocalizedString(@"Photo Album", nil)]) {
        [self openPhotoAlbum];
    } else if ([buttonTitle isEqualToString:NSLocalizedString(@"Camera", nil)]) {
        [self showCamera];
    }
}

#pragma mark - UIImagePickerControllerDelegate methods

/*
 Open PECropViewController automattically when image selected.
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (_SelectedUserType == userTypeTeacher) {
        self.imageViewOne.image = image;
    } else {
        self.imageView.image = image;
    }
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        
        [self updateEditButtonEnabled];
        
        [self openEditor:nil];
    } else {
        [picker dismissViewControllerAnimated:YES completion:^{
            [self openEditor:nil];
        }];
    }
}

-(void)UserTypeSelect:(UIButton *)sender
{
    _loginDeviceType = loginDeviceNo;
    _receiveEmailType = receiveEmailNo;
    [_TeacherReceiveEmailButton setImage:[UIImage imageNamed:kConfigCheckboxNormalKey] forState:UIControlStateNormal];
    [_TeacherLogedinDeviceButton setImage:[UIImage imageNamed:kConfigCheckboxNormalKey] forState:UIControlStateNormal];
    [_StudentReceiveEmailButton setImage:[UIImage imageNamed:kConfigCheckboxNormalKey] forState:UIControlStateNormal];
    [_StudentLogedinDeviceButton setImage:[UIImage imageNamed:kConfigCheckboxNormalKey] forState:UIControlStateNormal];
    
    if (_SelectedUserType == userTypeTeacher)
    {
        [_LoginMainBgScrollView setContentSize:CGSizeMake(_LoginMainBgScrollView.contentSize.width, _LoginMainBgScrollView.frame.size.height*1.9)];
        [_StudentTypeView removeFromSuperview];
        [_TeacherTypeView setFrame:CGRectMake(0, [kConfigAttachedViewYPosition floatValue], _TeacherTypeView.frame.size.width, _TeacherTypeView.frame.size.height)];
        [_LoginMainBgScrollView addSubview:_TeacherTypeView];
    }
    else if (_SelectedUserType == userTypeStudent)
    {
        [_LoginMainBgScrollView setContentSize:CGSizeMake(_LoginMainBgScrollView.contentSize.width, _LoginMainBgScrollView.frame.size.height*1.4)];
        [_TeacherTypeView removeFromSuperview];
        [_StudentTypeView setFrame:CGRectMake(0, [kConfigAttachedViewYPosition floatValue], _TeacherTypeView.frame.size.width, _TeacherTypeView.frame.size.height)];
        [_LoginMainBgScrollView addSubview:_StudentTypeView];
    }
}

-(void)UserTypeChanged {
    
    if (_SelectedUserType == userTypeTeacher)
    {
        [_LoginMainBgScrollView setContentSize:CGSizeMake(_LoginMainBgScrollView.contentSize.width, _LoginMainBgScrollView.frame.size.height*1.2)];
        [_StudentTypeView removeFromSuperview];
        [_TeacherTypeView setFrame:CGRectMake(0, [kConfigAttachedViewYPosition floatValue], _TeacherTypeView.frame.size.width, _TeacherTypeView.frame.size.height)];
        [_LoginMainBgScrollView addSubview:_TeacherTypeView];
    }
    else if (_SelectedUserType == userTypeStudent)
    {
        //[_LoginMainBgScrollView setContentSize:CGSizeMake(_LoginMainBgScrollView.contentSize.width, _LoginMainBgScrollView.frame.size.height*1.0)];
        [_TeacherTypeView removeFromSuperview];
        [_StudentTypeView setFrame:CGRectMake(0, [kConfigAttachedViewYPosition floatValue], _TeacherTypeView.frame.size.width, _TeacherTypeView.frame.size.height)];
        [_LoginMainBgScrollView addSubview:_StudentTypeView];
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view setBackgroundColor:Constant.ColorSPAWhiteColor];
    
    [self CustomizeHeaderwithTitle:@"my profile" WithFontName:Constant.FontRobotoBold WithFontSize:32];
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
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MenuWidth+10, 10, HeaderView.layer.frame.size.width-20, HeaderView.layer.frame.size.height-10)];
    [TitleLabel setBackgroundColor:[UIColor clearColor]];
    [TitleLabel setTextColor:Constant.ColorSPAWhiteColor];
    [TitleLabel setText:Title];
    [TitleLabel setTextAlignment:NSTextAlignmentLeft];
    [TitleLabel setFont:[UIFont fontWithName:FontName size:Size]];
    [HeaderView addSubview:TitleLabel];
}

#pragma mark - ValidateAccount

-(BOOL)ValidateTeacherTypeEditProfileForm
{
    BOOL validate = YES;
    
   if ([Constant CleanTextField:_TeacherNameTextfield.text].length== 0) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10002 Message:@"Name please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if ([Constant CleanTextField:_TeacherSchoolTextfield.text].length == 0) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10007 Message:@"School Please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if ([Constant CleanTextField:_TeacherOfficeLocationTextfield.text].length == 0) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10008 Message:@"Office location please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if ([Constant CleanTextField:_TeacherOfficeHoursTextfield.text].length == 0) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10009 Message:@"Office hours please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if ([Constant CleanTextField:_TeacherPhoneTextfield.text].length == 0) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10010 Message:@"Phone number please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    }
    return validate;
}

-(BOOL)ValidateStudentTypeEditProfileForm
{
    BOOL validate = YES;
    
    if ([Constant CleanTextField:_StudentNameTextfield.text].length== 0) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10014 Message:@"Name please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    }
    return validate;
}

-(BOOL)ValidateEditPasswordForm
{
    BOOL validate = YES;
    
    if ([Constant CleanTextField:_EditPasswordOldPassword.text].length == 0) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10012 Message:@"Old Password please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if ([Constant CleanTextField:_EditPasswordNewPassword.text].length== 0) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10014 Message:@"New Password please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if ([Constant CleanTextField:_EditPasswordNewPassword.text].length < 6) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10016 Message:@"Password must be 6 character" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    }else if ([Constant CleanTextField:_EditPasswordCOnfirmPassword.text].length== 0) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10014 Message:@"Retype Password please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if (![[Constant CleanTextField:_EditPasswordNewPassword.text] isEqualToString:[Constant CleanTextField:_EditPasswordCOnfirmPassword.text]]) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10017 Message:@"Password not matching" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    }
    return validate;
}

#pragma mark - Navigate to different Screen

-(void)ProcessSaveData {
    
    if (_DataSaveOption == dataSaveOptionEditProfile) {
        
        if (_SelectedUserType == userTypeTeacher) {
            if ([self ValidateTeacherTypeEditProfileForm]) {
                
                SPAEditTeacherProfileCompletionBlock completionBlock = ^(NSDictionary* data, NSString* errorString) {
                    
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
                    _DataSaveOption = dataSaveOptionNone;
                };
                
                SPAEditTeacherProfileSource * source = [SPAEditTeacherProfileSource editTeacherProfileSource];
                
                [Constant CleanTextField:_TeacherNameTextfield.text];
                
                [source editTeacherProfile:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[FeatchUserdetails uid]],[self getUserType],[Constant CleanTextField:_TeacherNameTextfield.text],[Constant CleanTextField:_TeacherPhoneTextfield.text],[Constant CleanTextField:_TeacherSchoolTextfield.text],[Constant CleanTextField:_TeacherOfficeLocationTextfield.text],[Constant CleanTextField:_TeacherOfficeHoursTextfield.text],[self getLoginDeviceStatus],[self getEmailReciveStatus],[UIImageJPEGRepresentation(self.imageViewOne.image, 0.7) base64EncodedStringWithOptions:0],@"jpg", nil] withImageData:nil completion:completionBlock];
                
                AppDelegate *MainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                _ActivityIndicator = [MBProgressHUD showHUDAddedTo:MainDelegate.window animated:YES];
                _ActivityIndicator.mode = MBProgressHUDModeIndeterminate;
                [_ActivityIndicator setOpacity:1.0];
                [_ActivityIndicator show:NO];
                _ActivityIndicator.labelText = @"Loading";
                
            }
        } else if (_SelectedUserType == userTypeStudent) {
            if ([self ValidateStudentTypeEditProfileForm]) {
                
                SPAEditStudentProfileCompletionBlock completionBlock = ^(NSDictionary* data, NSString* errorString) {
                    
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
                    _DataSaveOption = dataSaveOptionNone;
                };
                
                SPAEditStudentProfileSource * source = [SPAEditStudentProfileSource editStudentProfileSource];
                
                [Constant CleanTextField:_TeacherNameTextfield.text];
                
                [source editStudentProfile:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[FeatchUserdetails uid]],[self getUserType],[Constant CleanTextField:_StudentNameTextfield.text],@"",@"",@"",@"",[self getLoginDeviceStatus],[self getEmailReciveStatus],[UIImageJPEGRepresentation(self.imageView.image, 0.7) base64EncodedStringWithOptions:0],@"jpg", nil] withImageData:nil completion:completionBlock];
                
                AppDelegate *MainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                _ActivityIndicator = [MBProgressHUD showHUDAddedTo:MainDelegate.window animated:YES];
                _ActivityIndicator.mode = MBProgressHUDModeIndeterminate;
                [_ActivityIndicator setOpacity:1.0];
                [_ActivityIndicator show:NO];
                _ActivityIndicator.labelText = @"Loading";
                
            }
        }
        
    } else if (_DataSaveOption == dataSaveOptionChangePassword) {
        
        SPAChangePasswordCompletionBlock completionBlock = ^(NSDictionary* data, NSString* errorString) {
            
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
            _DataSaveOption = dataSaveOptionNone;
            [self OpenChangePasswordButton];
        };
        
        SPAChangePasswordSource * source = [SPAChangePasswordSource ChangePasswordSource];
        [source doChangePassword:[NSArray arrayWithObjects:[FeatchUserdetails uid],[Constant CleanTextField:_EditPasswordOldPassword.text],[Constant CleanTextField:_EditPasswordNewPassword.text], nil] completion:completionBlock];
        
        AppDelegate *MainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        _ActivityIndicator = [MBProgressHUD showHUDAddedTo:MainDelegate.window animated:YES];
        _ActivityIndicator.mode = MBProgressHUDModeIndeterminate;
        [_ActivityIndicator setOpacity:1.0];
        [_ActivityIndicator show:NO];
        _ActivityIndicator.labelText = @"Loading";
    }
}
-(void)GotoSignup {
    
    [self.navigationController pushViewController:Constant.SignupController animated:YES];
}
-(void)GotoViewProfile {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

@end
