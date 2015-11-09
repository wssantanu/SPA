//
//  SignupController.m
//  SPA
//
//  Created by Santanu Das Adhikary on 14/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "SignupController.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "PECropViewController.h"
#import "SPAsignupSource.h"
#import <JNKeychain/JNKeychain.h>

typedef enum {
    userTypeTeacher,
    userTypeStudent
} userType;

typedef enum {
    receiveEmailNo,
    receiveEmailYes
} receiveEmail;

typedef enum {
    loginDeviceNo,
    loginDeviceYes
} loginDevice;

#define kConfigScrollviewKey @"121"
//#define kConfigEmailTitleLabelKey @"122"
//#define kConfigPasswordTitleLabelKey @"124"
//#define kConfigEmailTextFiledKey @"123"
//#define kConfigPasswordTextFiledKey @"125"
//#define kConfigLoginButtonKey @"126"
//#define kConfigSignupButtonKey @"127"
//#define kConfigForgetPasswordButtonKey @"128"

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

#define kConfigTeacherTypeLoginButtonKey @"6213"
#define kConfigTeacherTypeRegistrationButtonKey @"6214"
#define kConfigTeacherTypeCancelButtonKey @"6215"
#define kConfigStudentTypeLoginButtonKey @"7213"
#define kConfigStudentTypeRegistrationButtonKey @"7214"
#define kConfigStudentTypeCancelButtonKey @"7215"

#define kConfigAttachedViewYPosition @"60"

#define kConfigSendEmailYes @"1"
#define kConfigSendEmailNo @"0"
#define kConfigLoginDeviceYes @"1"
#define kConfigLoginDeviceNo @"0"
#define kConfiguserTypeTeacher @"4"
#define kConfiguserTypeStudent @"5"

@interface SignupController()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, PECropViewControllerDelegate,UITextFieldDelegate>{
    __weak id<UIScrollViewDelegate> _scrollViewDelegate;
    __weak id<UITextFieldDelegate> _textFieldDelegate;
}

@property (nonatomic,retain) UIScrollView *LoginMainBgScrollView;

@property (nonatomic,retain) UILabel *LoginEmailTitleLabel,*LoginPasswordTitleLabel;

@property (nonatomic,retain) UIButton *LoginButton,*SignupButton,*ForgetPasswordButton,*TeacherTypeButton,*StudentTypeButton,*TeacherReceiveEmailButton,*TeacherLogedinDeviceButton,*StudentReceiveEmailButton,*StudentLogedinDeviceButton,*TeacherLoginButton,*TeacherSignupButton,*TeacherForgetPasswordButton,*StudentLoginButton,*StudentSignupButton,*StudentForgetPasswordButton;

@property (nonatomic,retain) IBOutlet UIButton *TeacherTypeCancelButton,*TeacherTypeLoginButton,*StudentTypeCancelButton,*StudentTypeLoginButton;

@property (nonatomic,retain) IBOutlet UIView *TeacherTypeView,*StudentTypeView;

@property (nonatomic,retain) UITextField *TeacherEmailTextfield,*TeacherNameTextfield,*TeacherPasswordTextfield,*TeacherConfirmPasswordTextfield,*TeacherSchoolTextfield,*TeacherOfficeLocationTextfield,*TeacherOfficeHoursTextfield,*TeacherPhoneTextfield,*StudentEmailTextfield,*StudentNameTextfield,*StudentPasswordTextfield,*StudentConfirmPasswordTextfield,*LoginEmailTextFiled,*LoginPasswordTextFiled;

@property (assign) userType     SelectedUserType;
@property (assign) receiveEmail receiveEmailType;
@property (assign) loginDevice  loginDeviceType;

@property (nonatomic) UIPopoverController           *popover;
@property (nonatomic, weak) IBOutlet UIButton       *editButton;
@property (nonatomic, weak) IBOutlet UIImageView    *imageView,*imageViewOne;
@property (nonatomic, weak) IBOutlet UIButton       *cameraButton;
@property (nonatomic,retain) MBProgressHUD          *ActivityIndicator;

@end
@implementation SignupController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Define scrollview
        
        _LoginMainBgScrollView = (UIScrollView *)[self.view viewWithTag:[kConfigScrollviewKey intValue]];
        [_LoginMainBgScrollView setScrollEnabled:YES];
        [_LoginMainBgScrollView setUserInteractionEnabled:YES];
        [_LoginMainBgScrollView setShowsHorizontalScrollIndicator:NO];
        [_LoginMainBgScrollView setShowsVerticalScrollIndicator:NO];
        [_LoginMainBgScrollView setDelegate:_scrollViewDelegate];
        
        // Define Textfiled
        
        _TeacherEmailTextfield              = (UITextField *)[_TeacherTypeView viewWithTag:[kConfigTeacherEmailTextfieldKey intValue]];
        _TeacherNameTextfield               = (UITextField *)[_TeacherTypeView viewWithTag:[kConfigTeacherNameTextfieldKey intValue]];
        _TeacherPasswordTextfield           = (UITextField *)[_TeacherTypeView viewWithTag:[kConfigTeacherPasswordTextfieldKey intValue]];
        _TeacherConfirmPasswordTextfield    = (UITextField *)[_TeacherTypeView viewWithTag:[kConfigTeacherConfirmPasswordTextfieldKey intValue]];
        _TeacherSchoolTextfield             = (UITextField *)[_TeacherTypeView viewWithTag:[kConfigTeacherSchoolTextfieldKey intValue]];
        _TeacherOfficeLocationTextfield     = (UITextField *)[_TeacherTypeView viewWithTag:[kConfigTeacherOfficeLocationTextfieldKey intValue]];
        _TeacherOfficeHoursTextfield        = (UITextField *)[_TeacherTypeView viewWithTag:[kConfigTeacherOfficeHoursTextfieldKey intValue]];
        _TeacherPhoneTextfield              = (UITextField *)[_TeacherTypeView viewWithTag:[kConfigTeacherPhoneTextfieldKey intValue]];
        
        _StudentEmailTextfield              = (UITextField *)[_StudentTypeView viewWithTag:[kConfigStudentEmailTextfieldKey intValue]];
        _StudentNameTextfield               = (UITextField *)[_StudentTypeView viewWithTag:[kConfigStudentNameTextfieldKey intValue]];
        _StudentPasswordTextfield           = (UITextField *)[_StudentTypeView viewWithTag:[kConfigStudentPasswordTextfieldKey intValue]];
        _StudentConfirmPasswordTextfield    = (UITextField *)[_StudentTypeView viewWithTag:[kConfigStudentConfirmPasswordTextfieldKey intValue]];
        
        _TeacherTypeButton                  = (UIButton *)[_LoginMainBgScrollView viewWithTag:[kConfigTeacherTypeButtonKey intValue]];
        _StudentTypeButton                  = (UIButton *)[_LoginMainBgScrollView viewWithTag:[kConfigStudentTypeButtonKey intValue]];
        
        _TeacherLoginButton                 = (UIButton *)[_TeacherTypeView viewWithTag:[kConfigTeacherTypeLoginButtonKey intValue]];
        _TeacherSignupButton                = (UIButton *)[_TeacherTypeView viewWithTag:[kConfigTeacherTypeRegistrationButtonKey intValue]];
        _TeacherForgetPasswordButton        = (UIButton *)[_TeacherTypeView viewWithTag:[kConfigTeacherTypeCancelButtonKey intValue]];
        _TeacherReceiveEmailButton          = (UIButton *)[_TeacherTypeView viewWithTag:[kConfigTeacherReceiveEmailTypeButtonKey intValue]];
        _TeacherLogedinDeviceButton         = (UIButton *)[_TeacherTypeView viewWithTag:[kConfigTeacherLoginDeviceTypeButtonKey intValue]];
        
        _StudentLoginButton                 = (UIButton *)[_StudentTypeView viewWithTag:[kConfigStudentTypeLoginButtonKey intValue]];
        _StudentSignupButton                = (UIButton *)[_StudentTypeView viewWithTag:[kConfigStudentTypeRegistrationButtonKey intValue]];
        _StudentForgetPasswordButton        = (UIButton *)[_StudentTypeView viewWithTag:[kConfigStudentTypeCancelButtonKey intValue]];
        _StudentReceiveEmailButton          = (UIButton *)[_StudentTypeView viewWithTag:[kConfigStudentReceiveEmailTypeButtonKey intValue]];
        _StudentLogedinDeviceButton         = (UIButton *)[_StudentTypeView viewWithTag:[kConfigStudentLoginDeviceTypeButtonKey intValue]];
        
        [_TeacherTypeCancelButton addTarget:self action:@selector(GotoForgetPassword) forControlEvents:UIControlEventTouchUpInside];
        [_StudentTypeCancelButton addTarget:self action:@selector(GotoForgetPassword) forControlEvents:UIControlEventTouchUpInside];
        
        [_TeacherTypeLoginButton addTarget:self action:@selector(ProcessLogin) forControlEvents:UIControlEventTouchUpInside];
        [_StudentTypeLoginButton addTarget:self action:@selector(ProcessLogin) forControlEvents:UIControlEventTouchUpInside];
        
        _SelectedUserType = userTypeTeacher;
        _receiveEmailType = receiveEmailNo;
        _loginDeviceType  = loginDeviceNo;
        
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
                else if (AllButtonInView == _StudentTypeButton)
                {
                    [AllButtonInView addTarget:self action:@selector(UserTypeSelect:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }
        
        for (id AllTextFiled in [_LoginMainBgScrollView subviews]) {
            if ([AllTextFiled isKindOfClass:[UITextField class]]) {
                UITextField *AllTextFiledInView = (UITextField *)AllTextFiled;
                [AllTextFiledInView setDelegate:self];
                [AllTextFiledInView setBorderStyle:UITextBorderStyleLine];
            }
        }
        
        // Teacher Type View
        
        for (id AllLabel in [_TeacherTypeView subviews]) {
            if ([AllLabel isKindOfClass:[UILabel class]]) {
                UILabel *AllLabelInView = (UILabel *)AllLabel;
                [AllLabelInView setTextColor:Constant.ColorSPABlackColor];
                (AllLabelInView.tag == 1122)?[AllLabelInView setFont:[UIFont fontWithName:Constant.FontRobotoRegular size:12]]:[AllLabelInView setFont:[UIFont fontWithName:Constant.FontRobotoRegular size:16]];
            }
        }
        
        for (id AllButton in [_TeacherTypeView subviews]) {
            if ([AllButton isKindOfClass:[UIButton class]]) {
                
                UIButton *AllButtonInView = (UIButton *)AllButton;
                
                if (AllButtonInView == _TeacherLoginButton)
                    [AllButtonInView addTarget:self action:@selector(ProcessLogin) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _TeacherSignupButton)
                    [AllButtonInView addTarget:self action:@selector(GotoSignup) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _TeacherForgetPasswordButton)
                    [AllButtonInView addTarget:self action:@selector(GotoForgetPassword) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _TeacherReceiveEmailButton)
                    [AllButtonInView addTarget:self action:@selector(changeSettings:) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _TeacherLogedinDeviceButton)
                    [AllButtonInView addTarget:self action:@selector(changeSettings:) forControlEvents:UIControlEventTouchUpInside];
                
                [AllButtonInView.titleLabel setTextColor:Constant.ColorSPAWhiteColor];
            }
        }
        
        for (id AllTextFiled in [_TeacherTypeView subviews]) {
            if ([AllTextFiled isKindOfClass:[UITextField class]]) {
                UITextField *AllTextFiledInView = (UITextField *)AllTextFiled;
                [AllTextFiledInView setDelegate:self];
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
        
        // Student Type View
        
        for (id AllLabel in [_StudentTypeView subviews]) {
            if ([AllLabel isKindOfClass:[UILabel class]]) {
                UILabel *AllLabelInView = (UILabel *)AllLabel;
                [AllLabelInView setTextColor:Constant.ColorSPABlackColor];
                [AllLabelInView setFont:[UIFont fontWithName:Constant.FontRobotoRegular size:16]];
                (AllLabelInView.tag == 2125)?[AllLabelInView setFont:[UIFont fontWithName:Constant.FontRobotoRegular size:12]]:[AllLabelInView setFont:[UIFont fontWithName:Constant.FontRobotoRegular size:16]];
            }
        }
        
        for (id AllButton in [_StudentTypeView subviews]) {
            if ([AllButton isKindOfClass:[UIButton class]]) {
                
                UIButton *AllButtonInView = (UIButton *)AllButton;
                
                if (AllButtonInView == _StudentLoginButton)
                    [AllButtonInView addTarget:self action:@selector(ProcessLogin) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _StudentSignupButton)
                    [AllButtonInView addTarget:self action:@selector(GotoSignup) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _StudentForgetPasswordButton)
                    [AllButtonInView addTarget:self action:@selector(GotoForgetPassword) forControlEvents:UIControlEventTouchUpInside];
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
                [AllTextFiledInView setDelegate:self];
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
        [self UserTypeChanged];
    }
    return self;
}

-(void)UserTypeSelect:(UIButton *)sender
{
    if (sender.tag == [kConfigTeacherTypeButtonKey intValue]){
        if (_SelectedUserType != userTypeTeacher) {
            [_TeacherTypeButton setImage:[UIImage imageNamed:kConfigRedioButtonSelectedKey] forState:UIControlStateNormal];
            [_StudentTypeButton setImage:[UIImage imageNamed:kConfigRedioButtonNormalKey] forState:UIControlStateNormal];
            _SelectedUserType = userTypeTeacher;
            [self UserTypeChanged];
        }
    } else if (sender.tag == [kConfigStudentTypeButtonKey intValue]) {
        if (_SelectedUserType != userTypeStudent) {
            [_TeacherTypeButton setImage:[UIImage imageNamed:kConfigRedioButtonNormalKey] forState:UIControlStateNormal];
            [_StudentTypeButton setImage:[UIImage imageNamed:kConfigRedioButtonSelectedKey] forState:UIControlStateNormal];
            _SelectedUserType = userTypeStudent;
            [self UserTypeChanged];
        }
    }
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

-(void)UserTypeChanged {
    
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

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view setBackgroundColor:Constant.ColorSPAWhiteColor];
    
    [self CustomizeHeaderwithTitle:@"Create Account" WithFontName:Constant.FontRobotoBold WithFontSize:32];
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

#pragma mark - ValidateAccount

-(BOOL)ValidateTeacherTypeSignupForm
{
    BOOL validate = YES;
    
    if ([Constant CleanTextField:_TeacherEmailTextfield.text].length == 0) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10000 Message:@"Email please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if (![Constant ValidateEmail:[Constant CleanTextField:_TeacherEmailTextfield.text]]) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10001 Message:@"Proper Email please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if ([Constant CleanTextField:_TeacherNameTextfield.text].length== 0) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10002 Message:@"Name please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if ([Constant CleanTextField:_TeacherPasswordTextfield.text].length== 0) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10003 Message:@"Password please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if ([Constant CleanTextField:_TeacherPasswordTextfield.text].length < 6) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10004 Message:@"Password must be 6 character" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if ([Constant CleanTextField:_TeacherConfirmPasswordTextfield.text].length == 0) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10005 Message:@"Retype password please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if (![[Constant CleanTextField:_TeacherPasswordTextfield.text] isEqualToString:[Constant CleanTextField:_TeacherConfirmPasswordTextfield.text]]) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10006 Message:@"Password not matching" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
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
//    else if ([Constant validatePhone:[Constant CleanTextField:_TeacherPhoneTextfield.text]] == NO) {
//        [super ShowAletviewWIthTitle:AlertTitle Tag:10011 Message:@"Proper Phone number please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
//        validate = NO;
//    }
    return validate;
}

-(BOOL)ValidateStudentTypeSignupForm
{
    BOOL validate = YES;
    
    if ([Constant CleanTextField:_StudentEmailTextfield.text].length == 0) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10012 Message:@"Email please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if (![Constant ValidateEmail:[Constant CleanTextField:_StudentEmailTextfield.text]]) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10013 Message:@"Proper Email please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if ([Constant CleanTextField:_StudentNameTextfield.text].length== 0) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10014 Message:@"Name please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if ([Constant CleanTextField:_StudentPasswordTextfield.text].length== 0) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10015 Message:@"Password please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if ([Constant CleanTextField:_StudentPasswordTextfield.text].length < 6) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10016 Message:@"Password must be 6 character" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if ([Constant CleanTextField:_StudentConfirmPasswordTextfield.text].length == 0) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10017 Message:@"Retype password please" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    } else if (![[Constant CleanTextField:_StudentPasswordTextfield.text] isEqualToString:[Constant CleanTextField:_StudentConfirmPasswordTextfield.text]]) {
        [super ShowAletviewWIthTitle:AlertTitle Tag:10018 Message:@"Password not matching" CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
        validate = NO;
    }
    return validate;
}

#pragma mark - Navigate to different Screen

-(void)ProcessLogin {
    [self.navigationController pushViewController:Constant.LoginViewController animated:YES];
}
-(void)GotoSignup {
    if (_SelectedUserType == userTypeTeacher) {
        if ([self ValidateTeacherTypeSignupForm]) {
            
            SPASignupCompletionBlock completionBlock = ^(NSDictionary* data, NSString* errorString) {
                
                [_ActivityIndicator hide:YES];
                if (errorString) {
                    if (errorString.length>0) {
                        [super ShowAletviewWIthTitle:@"Sorry" Tag:780 Message:[[errorString substringToIndex:[errorString length] - 2] substringFromIndex:2] CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
                    }
                } else {
                    [super ShowAletviewWIthTitle:@"Success" Tag:780 Message:[data objectForKey:@"message"] CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
                }
            };
            
            SPAsignupSource * source = [SPAsignupSource signupDetailsSource];
            
            if (UIImageJPEGRepresentation(self.imageViewOne.image, 0.7)!=NULL)
            {
                [source getsignupDetails:[NSArray arrayWithObjects:[self getUserType],@"jpg",[Constant CleanTextField:[_TeacherEmailTextfield text]],[Constant CleanTextField:[_TeacherPasswordTextfield text]],[Constant CleanTextField:[_TeacherNameTextfield text]],[Constant CleanTextField:[_TeacherSchoolTextfield text]],[Constant CleanTextField:[_TeacherOfficeLocationTextfield text]],[Constant CleanTextField:[_TeacherPhoneTextfield text]],[self getLoginDeviceStatus],[self getEmailReciveStatus],[Constant CleanTextField:[_TeacherOfficeHoursTextfield text]],[UIImageJPEGRepresentation(self.imageViewOne.image, 0.7) base64EncodedStringWithOptions:0], nil] withImageData:nil completion:completionBlock];
            }
            else
            {
                [source getsignupDetails:[NSArray arrayWithObjects:[self getUserType],@"",[Constant CleanTextField:[_TeacherEmailTextfield text]],[Constant CleanTextField:[_TeacherPasswordTextfield text]],[Constant CleanTextField:[_TeacherNameTextfield text]],[Constant CleanTextField:[_TeacherSchoolTextfield text]],[Constant CleanTextField:[_TeacherOfficeLocationTextfield text]],[Constant CleanTextField:[_TeacherPhoneTextfield text]],[self getLoginDeviceStatus],[self getEmailReciveStatus],[Constant CleanTextField:[_TeacherOfficeHoursTextfield text]],@"", nil] withImageData:nil completion:completionBlock];
            }
            
            [JNKeychain saveValue:[Constant CleanTextField:_LoginEmailTextFiled.text] forKey:KeychainUserEmailkey];
            [JNKeychain saveValue:[Constant CleanTextField:_LoginPasswordTextFiled.text] forKey:KeychainUserPasswordkey];
            
            _ActivityIndicator = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            _ActivityIndicator.mode = MBProgressHUDModeIndeterminate;
            [_ActivityIndicator setOpacity:1.0];
            [_ActivityIndicator show:NO];
            _ActivityIndicator.labelText = @"Loading";
            
        }
    } else if (_SelectedUserType == userTypeStudent) {
        if ([self ValidateStudentTypeSignupForm])
        {
            SPASignupCompletionBlock completionBlock = ^(NSDictionary* data, NSString* errorString) {
                
                [_ActivityIndicator hide:YES];
                if (errorString) {
                    if (errorString.length>0) {
                        [super ShowAletviewWIthTitle:@"Sorry" Tag:780 Message:[[errorString substringToIndex:[errorString length] - 2] substringFromIndex:2] CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
                    }
                } else {
                    [super ShowAletviewWIthTitle:@"Success" Tag:780 Message:[data objectForKey:@"message"] CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
                }
            };
            
            SPAsignupSource * source = [SPAsignupSource signupDetailsSource];
            
            if (UIImageJPEGRepresentation(self.imageView.image, 0.7)!=NULL)
            {
                [source getsignupDetails:[NSArray arrayWithObjects:[self getUserType],@"jpg",[Constant CleanTextField:[_StudentEmailTextfield text]],[Constant CleanTextField:[_StudentPasswordTextfield text]],[Constant CleanTextField:[_StudentNameTextfield text]],@"",@"",@"",[self getLoginDeviceStatus],[self getEmailReciveStatus],@"",[UIImageJPEGRepresentation(self.imageView.image, 0.7) base64EncodedStringWithOptions:0], nil] withImageData:nil completion:completionBlock];
            }
            else
            {
                [source getsignupDetails:[NSArray arrayWithObjects:[self getUserType],@"",[Constant CleanTextField:[_StudentEmailTextfield text]],[Constant CleanTextField:[_StudentPasswordTextfield text]],[Constant CleanTextField:[_StudentNameTextfield text]],@"",@"",@"",[self getLoginDeviceStatus],[self getEmailReciveStatus],@"",@"", nil] withImageData:nil completion:completionBlock];
            }
            
            [JNKeychain saveValue:[Constant CleanTextField:_LoginEmailTextFiled.text] forKey:KeychainUserEmailkey];
            [JNKeychain saveValue:[Constant CleanTextField:_LoginPasswordTextFiled.text] forKey:KeychainUserPasswordkey];
            
            _ActivityIndicator = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            _ActivityIndicator.mode = MBProgressHUDModeIndeterminate;
            [_ActivityIndicator setOpacity:1.0];
            [_ActivityIndicator show:NO];
            _ActivityIndicator.labelText = @"Loading";
        }
    }
}
-(void)GotoForgetPassword {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

#pragma mark - UITextfield Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_SelectedUserType == userTypeTeacher) {
        if (textField == _TeacherPasswordTextfield) {
            [_LoginMainBgScrollView setContentOffset:CGPointMake(_LoginMainBgScrollView.frame.origin.x, 100) animated:YES];
        } else if (textField == _TeacherConfirmPasswordTextfield) {
            [_LoginMainBgScrollView setContentOffset:CGPointMake(_LoginMainBgScrollView.frame.origin.x, 200) animated:YES];
        } else if (textField == _TeacherSchoolTextfield) {
            [_LoginMainBgScrollView setContentOffset:CGPointMake(_LoginMainBgScrollView.frame.origin.x, 300) animated:YES];
        }else if (textField == _TeacherOfficeLocationTextfield) {
            [_LoginMainBgScrollView setContentOffset:CGPointMake(_LoginMainBgScrollView.frame.origin.x, 400) animated:YES];
        }else if (textField == _TeacherOfficeHoursTextfield) {
            [_LoginMainBgScrollView setContentOffset:CGPointMake(_LoginMainBgScrollView.frame.origin.x, 500) animated:YES];
        }else if (textField == _TeacherPhoneTextfield) {
            [_LoginMainBgScrollView setContentOffset:CGPointMake(_LoginMainBgScrollView.frame.origin.x, 600) animated:YES];
        }
    } else if (_SelectedUserType == userTypeStudent) {
        NSLog(@"textField => %@",textField);
        if (textField == _StudentPasswordTextfield) {
            [_LoginMainBgScrollView setContentOffset:CGPointMake(_LoginMainBgScrollView.frame.origin.x, 200) animated:YES];
        } else if (textField == _StudentConfirmPasswordTextfield) {
            [_LoginMainBgScrollView setContentOffset:CGPointMake(_LoginMainBgScrollView.frame.origin.x, 300) animated:YES];
        }
    }
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [textField resignFirstResponder];
    [_LoginMainBgScrollView setContentOffset:CGPointMake(_LoginMainBgScrollView.frame.origin.x, _LoginMainBgScrollView.frame.origin.x) animated:YES];
    return YES;
}

@end
