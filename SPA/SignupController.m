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

/**
 A Boolean value indicating whether the manager is enabled.
 
 If YES, the manager will change status bar network activity indicator according to network operation notifications it receives. The default value is NO.
 */

typedef enum {
    userTypeTeacher,
    userTypeStudent
} userType;

#define kConfigScrollviewKey @"121"
#define kConfigEmailTitleLabelKey @"122"
#define kConfigPasswordTitleLabelKey @"124"
#define kConfigEmailTextFiledKey @"123"
#define kConfigPasswordTextFiledKey @"125"
#define kConfigLoginButtonKey @"126"
#define kConfigSignupButtonKey @"127"
#define kConfigForgetPasswordButtonKey @"128"

#define kConfigTeacherTypeButtonKey @"999"
#define kConfigStudentTypeButtonKey @"888"

#define kConfigAttachedViewYPosition @"100"

@interface SignupController()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, PECropViewControllerDelegate>{
    __weak id<UIScrollViewDelegate> _scrollViewDelegate;
    __weak id<UITextFieldDelegate> _textFieldDelegate;
}

@property (nonatomic,retain) UIScrollView *LoginMainBgScrollView;
@property (nonatomic,retain) UILabel *LoginEmailTitleLabel,*LoginPasswordTitleLabel;
@property (nonatomic,retain) UITextField *LoginEmailTextFiled,*LoginPasswordTextFiled;
@property (nonatomic,retain) UIButton *LoginButton,*SignupButton,*ForgetPasswordButton,*TeacherTypeButton,*StudentTypeButton;
@property (nonatomic,retain) IBOutlet UIView *TeacherTypeView,*StudentTypeView;
@property (assign) userType SelectedUserType;
@property (nonatomic) UIPopoverController *popover;
@property (nonatomic, weak) IBOutlet UIButton *editButton;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIButton *cameraButton;

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
        
        // Define UILabel
        
        _LoginEmailTitleLabel       = (UILabel *)[_LoginMainBgScrollView viewWithTag:[kConfigEmailTitleLabelKey intValue]];
        _LoginPasswordTitleLabel    = (UILabel *)[_LoginMainBgScrollView viewWithTag:[kConfigPasswordTitleLabelKey intValue]];
        
        // Define Textfiled
        
        _LoginEmailTextFiled       = (UITextField *)[_LoginMainBgScrollView viewWithTag:[kConfigEmailTextFiledKey intValue]];
        _LoginPasswordTextFiled    = (UITextField *)[_LoginMainBgScrollView viewWithTag:[kConfigPasswordTextFiledKey intValue]];
        
        // Define Button
        
        _LoginButton                = (UIButton *)[_LoginMainBgScrollView viewWithTag:[kConfigLoginButtonKey intValue]];
        _SignupButton               = (UIButton *)[_LoginMainBgScrollView viewWithTag:[kConfigSignupButtonKey intValue]];
        _ForgetPasswordButton       = (UIButton *)[_LoginMainBgScrollView viewWithTag:[kConfigForgetPasswordButtonKey intValue]];
        
        _TeacherTypeButton       = (UIButton *)[_LoginMainBgScrollView viewWithTag:[kConfigTeacherTypeButtonKey intValue]];
        _StudentTypeButton       = (UIButton *)[_LoginMainBgScrollView viewWithTag:[kConfigStudentTypeButtonKey intValue]];
        
        _SelectedUserType = userTypeTeacher;
        
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
                //[AllButtonInView.titleLabel setTextColor:Constant.ColorSPAWhiteColor];
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
                
                if (AllButtonInView == _LoginButton)
                    [AllButtonInView addTarget:self action:@selector(ProcessLogin) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _SignupButton)
                    [AllButtonInView addTarget:self action:@selector(GotoSignup) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _ForgetPasswordButton)
                    [AllButtonInView addTarget:self action:@selector(GotoForgetPassword) forControlEvents:UIControlEventTouchUpInside];
                
                [AllButtonInView.titleLabel setTextColor:Constant.ColorSPAWhiteColor];
            }
        }
        
        for (id AllTextFiled in [_TeacherTypeView subviews]) {
            if ([AllTextFiled isKindOfClass:[UITextField class]]) {
                UITextField *AllTextFiledInView = (UITextField *)AllTextFiled;
                [AllTextFiledInView setDelegate:_textFieldDelegate];
                [AllTextFiledInView setBorderStyle:UITextBorderStyleLine];
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
                
                if (AllButtonInView == _LoginButton)
                    [AllButtonInView addTarget:self action:@selector(ProcessLogin) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _SignupButton)
                    [AllButtonInView addTarget:self action:@selector(GotoSignup) forControlEvents:UIControlEventTouchUpInside];
                else if (AllButtonInView == _ForgetPasswordButton)
                    [AllButtonInView addTarget:self action:@selector(GotoForgetPassword) forControlEvents:UIControlEventTouchUpInside];
                
                [AllButtonInView.titleLabel setTextColor:Constant.ColorSPAWhiteColor];
            }
        }
        
        for (id AllTextFiled in [_StudentTypeView subviews]) {
            if ([AllTextFiled isKindOfClass:[UITextField class]]) {
                UITextField *AllTextFiledInView = (UITextField *)AllTextFiled;
                [AllTextFiledInView setDelegate:_textFieldDelegate];
                [AllTextFiledInView setBorderStyle:UITextBorderStyleLine];
            }
        }
        
        [self UserTypeChanged];
    }
    return self;
}

#pragma mark - PECropViewControllerDelegate methods

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage transform:(CGAffineTransform)transform cropRect:(CGRect)cropRect
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    self.imageView.image = croppedImage;
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
    controller.image = self.imageView.image;
    
    UIImage *image = self.imageView.image;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat length = MIN(width, height);
    controller.imageCropRect = CGRectMake((width - length) / 2,
                                          (height - length) / 2,
                                          length,
                                          length);
    
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
    self.editButton.enabled = !!self.imageView.image;
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
    self.imageView.image = image;
    
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
    if (sender.tag == [kConfigTeacherTypeButtonKey intValue]){
        if (_SelectedUserType != userTypeTeacher) {
            [_TeacherTypeButton setImage:[UIImage imageNamed:@"checkbox_selected"] forState:UIControlStateNormal];
            [_StudentTypeButton setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
            _SelectedUserType = userTypeTeacher;
            [self UserTypeChanged];
        }
    } else if (sender.tag == [kConfigStudentTypeButtonKey intValue]) {
        if (_SelectedUserType != userTypeStudent) {
            [_TeacherTypeButton setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
            [_StudentTypeButton setImage:[UIImage imageNamed:@"checkbox_selected"] forState:UIControlStateNormal];
            _SelectedUserType = userTypeStudent;
            [self UserTypeChanged];
        }
    }
}

-(void)UserTypeChanged {
    
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

#pragma mark - Navigate to different Screen

-(void)ProcessLogin {  }
-(void)GotoSignup { [self.navigationController pushViewController:Constant.SignupController animated:YES]; }
-(void)GotoForgetPassword { [self.navigationController pushViewController:Constant.ForgetPasswordControllerViewController animated:YES]; }

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

@end
