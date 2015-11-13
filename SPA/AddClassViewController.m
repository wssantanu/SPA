//
//  AddClassViewController.m
//  SPA
//
//  Created by Santanu Das Adhikary on 30/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "AddClassViewController.h"
#import "DEMONavigationController.h"
#import "UINavigationBar+Customnavigation.h"
#import "AddMoreView.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import "NKOColorPickerView.h"
#import <RMDateSelectionViewController/RMDateSelectionViewController.h>
#import "AppDelegate.h"
#import "DataModel.h"
#import "UserDetails.h"
#import "AddMoreTimeObject.h"
#import <math.h>

typedef enum {
    buttonrepostiontypenone,
    buttonrepostiontypeup,
    buttonrepostiontypedown
} buttonrepostiontype;

typedef enum {
    dateSelectiontypenone,
    dateSelectiontypestartdate,
    dateSelectiontypeenddate
} dateSelectiontype;

typedef enum {
    weakdaytypesunday,
    weakdaytypemonday,
    weakdaytypetuesday,
    weakdaytypewednesday,
    weakdaytypethirsday,
    weakdaytypefriday,
    weakdaytypesaturday
} weakdaytype;

typedef enum {
    aditionTypenormal,
    aditionTypeSegment
} aditionType;

@interface AddClassViewController ()<UIScrollViewDelegate,UITextFieldDelegate>

@property (nonatomic,retain) UIScrollView *MainScrollView;
@property (nonatomic,retain) NSMutableArray *GlobalTagArray,*GlobalTimeValArray;
@property (assign) buttonrepostiontype Buttonrepostiontype;
@property (assign) weakdaytype Weakdaytype;
@property (assign) aditionType AditionType;
@property (assign) dateSelectiontype DateSelectiontype;
@property (nonatomic,retain) UIView *ColorView;
@property (nonatomic,retain) UIImageView *checkBox;
@property (nonatomic,retain) UIButton *ColorPickerButton,*addAnotherButton,*cancelButton,*SaveButton;
@property (nonatomic,retain) NKOColorPickerView *colorPickerView;
@property (nonatomic,retain) UITextField *AddClassClassNameTextField,*AddClassClassColorTextField,*AddClassClassTeacherNameTextField,*AddClassClassLocationTextField,*AddClassClassSectionTextField,*AddClassClassSemesterTextField,*AddClassClassStartDateTextField,*AddClassClassEndDateTextField;
@property (nonatomic,retain) AppDelegate *Maindelegate;
@property (assign) UserDetails *FeatchUserdetails;
@property (nonatomic,retain) UILabel *ClassDaysLabel,*addAnotherLineLabel,*addLine;
@property (nonatomic,retain) IBOutlet UIView *FooerView;
@property (nonatomic,retain) UITapGestureRecognizer *singleFingerTap;
@end

@implementation AddClassViewController
{
    UIButton *SaveButton;
    HMSegmentedControl *segmentedControl1;
}

int addMoreViewTag = (int)AddmoreViewTag;

float scrollViewBasicHeight = 0.0f;
float saveButtonYposition = 0.0f;
bool IscolorPickerVisiable = NO;
BOOL ISValidated = YES;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _Buttonrepostiontype = buttonrepostiontypenone;
    _Weakdaytype = weakdaytypesunday;
    _AditionType = aditionTypenormal;
    _DateSelectiontype = dateSelectiontypenone;
    
    DataModel *dataModelObj = [DataModel sharedEngine];
    _FeatchUserdetails = [dataModelObj fetchCurrentUser];
    
    _GlobalTagArray = [[NSMutableArray alloc] initWithObjects:[[NSMutableArray alloc] initWithObjects:@1557, nil],[[NSMutableArray alloc] initWithObjects:@1558, nil],[[NSMutableArray alloc] initWithObjects:@1559, nil],[[NSMutableArray alloc] initWithObjects:@1560, nil],[[NSMutableArray alloc] initWithObjects:@1561, nil],[[NSMutableArray alloc] initWithObjects:@1562, nil],[[NSMutableArray alloc] initWithObjects:@1563, nil], nil];
    _GlobalTimeValArray = [[NSMutableArray alloc] init];
    
    for (int isx = 1557; isx<=1563; isx++)
    {
        AddMoreTimeObject *LocalTimeObject = [[AddMoreTimeObject alloc] initWithViewtag:[NSString stringWithFormat:@"%d",isx] StartTime:@"" EndTime:@""];
        [_GlobalTimeValArray addObject:LocalTimeObject];
    }
    
    [self CustomizeHeaderwithTitle:@"add class" WithFontName:Constant.FontRobotoMedium WithFontSize:32 withButton:NO withSelecter:nil WithButtonBgImage:nil];
    
    _MainScrollView = (UIScrollView *)[self.view viewWithTag:999];
    [_MainScrollView setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width-MenuWidth, [[UIScreen mainScreen] bounds].size.height)];
    [_MainScrollView setDelegate:self];
    [_MainScrollView setBackgroundColor:[UIColor clearColor]];
    
    _Maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _AddClassClassNameTextField = (UITextField *)[_MainScrollView viewWithTag:445];
    _AddClassClassColorTextField = (UITextField *)[_MainScrollView viewWithTag:446];
    _AddClassClassTeacherNameTextField = (UITextField *)[_MainScrollView viewWithTag:447];
    _AddClassClassLocationTextField = (UITextField *)[_MainScrollView viewWithTag:448];
    _AddClassClassSectionTextField = (UITextField *)[_MainScrollView viewWithTag:449];
    _AddClassClassSemesterTextField = (UITextField *)[_MainScrollView viewWithTag:450];
    _AddClassClassStartDateTextField = (UITextField *)[_MainScrollView viewWithTag:451];
    _AddClassClassEndDateTextField = (UITextField *)[_MainScrollView viewWithTag:452];
    _ClassDaysLabel = (UILabel *)[_MainScrollView viewWithTag:656];
    
    for (id AllLabel in [_MainScrollView subviews]) {
        if ([AllLabel isKindOfClass:[UILabel class]]) {
            UILabel *AllLabelInView = (UILabel *)AllLabel;
            [AllLabelInView setTextColor:Constant.ColorSPAGreyColor];
            [AllLabelInView setFont:[UIFont fontWithName:Constant.FontRobotoMedium size:16]];
        }
    }
    
    for (id AllTextFiled in [_MainScrollView subviews]) {
        if ([AllTextFiled isKindOfClass:[UITextField class]]) {
            UITextField *AllTextFiledInView = (UITextField *)AllTextFiled;
            [AllTextFiledInView setDelegate:self];
            [AllTextFiledInView setBorderStyle:UITextBorderStyleLine];
            
            if (AllTextFiledInView == _AddClassClassColorTextField) {
                
                UIView *LefftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AllTextFiledInView.frame.size.width/2, AllTextFiledInView.frame.size.height)];
                [LefftView setBackgroundColor:[UIColor clearColor]];
                [AllTextFiledInView setLeftView:LefftView];
                [AllTextFiledInView setLeftViewMode:UITextFieldViewModeAlways];
                
                _ColorView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, AllTextFiledInView.frame.size.height-10, AllTextFiledInView.frame.size.height-10)];
                [_ColorView setBackgroundColor:[UIColor greenColor]];
                [LefftView addSubview:_ColorView];
                
                UIView *RightView = [[UIView alloc] initWithFrame:CGRectMake(AllTextFiledInView.frame.size.width/2, 0, AllTextFiledInView.frame.size.width/2, AllTextFiledInView.frame.size.height)];
                [RightView setBackgroundColor:[UIColor clearColor]];
                [AllTextFiledInView setRightView:RightView];
                [AllTextFiledInView setRightViewMode:UITextFieldViewModeAlways];
                
                _ColorPickerButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, AllTextFiledInView.frame.size.height-10, AllTextFiledInView.frame.size.height-10)];
                [_ColorPickerButton setBackgroundColor:[UIColor clearColor]];
                [_ColorPickerButton setBackgroundImage:[UIImage imageNamed:@"Icon_dropdown"] forState:UIControlStateNormal];
                [_ColorPickerButton setBackgroundImage:[UIImage imageNamed:@"Icon_dropdown"] forState:UIControlStateSelected];
                [_ColorPickerButton setBackgroundImage:[UIImage imageNamed:@"Icon_dropdown"] forState:UIControlStateHighlighted];
                [_ColorPickerButton addTarget:self action:@selector(OpenColorPicker) forControlEvents:UIControlEventTouchUpInside];
                [RightView addSubview:_ColorPickerButton];
                
            } else if((AllTextFiledInView == _AddClassClassStartDateTextField) || (AllTextFiledInView == _AddClassClassEndDateTextField)) {
                
                UIView *LefftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, AllTextFiledInView.frame.size.height)];
                [LefftView setBackgroundColor:[UIColor clearColor]];
                [AllTextFiledInView setLeftView:LefftView];
                [AllTextFiledInView setLeftViewMode:UITextFieldViewModeAlways];
                
                UIView *RightView = [[UIView alloc] initWithFrame:CGRectMake(AllTextFiledInView.frame.size.width-AllTextFiledInView.frame.size.height, 0, AllTextFiledInView.frame.size.height, AllTextFiledInView.frame.size.height)];
                [RightView setBackgroundColor:[UIColor clearColor]];
                [AllTextFiledInView setRightView:RightView];
                [AllTextFiledInView setRightViewMode:UITextFieldViewModeAlways];
                
                UIImageView *calender1 =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,25,25)];
                [calender1 setCenter:CGPointMake(AllTextFiledInView.frame.size.height/2, AllTextFiledInView.frame.size.height/2)];
                calender1.image=[UIImage imageNamed:@"Icon_Calender"];
                [RightView addSubview:calender1];
            
            } else {
                
                UIView *LefftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, AllTextFiledInView.frame.size.height)];
                [LefftView setBackgroundColor:[UIColor clearColor]];
                [AllTextFiledInView setLeftView:LefftView];
                [AllTextFiledInView setLeftViewMode:UITextFieldViewModeAlways];
                
                if (AllTextFiledInView == _AddClassClassTeacherNameTextField) {
                    [_AddClassClassTeacherNameTextField setBackgroundColor:UIColorFromRGB(0xc5c5c5)];
                    [_AddClassClassTeacherNameTextField setUserInteractionEnabled:NO];
                    [_AddClassClassTeacherNameTextField setText:_FeatchUserdetails.user_full_name];
                }
            }
        }
    }
    
    NKOColorPickerDidChangeColorBlock colorDidChangeBlock = ^(UIColor *color){
        [UIView animateWithDuration:1.2 animations:^(void){
            NSLog(@"color ===> %@",[self hexStringFromColor:color]);
            [_ColorView setBackgroundColor:color];
        } completion:nil];
    };
    
    _colorPickerView = [[NKOColorPickerView alloc] initWithFrame:CGRectMake(10, 160, [[UIScreen mainScreen] bounds].size.width-20, [[UIScreen mainScreen] bounds].size.width-20) color:[UIColor redColor] andDidChangeColorBlock:colorDidChangeBlock];
    [_colorPickerView setBackgroundColor:[UIColor lightGrayColor]];
    [_colorPickerView.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [_colorPickerView.layer setBorderWidth:1.0f];
    [_colorPickerView setHidden:YES];
    [_Maindelegate.window addSubview:_colorPickerView];
    
    _singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [_singleFingerTap setNumberOfTapsRequired:1];
    [_MainScrollView setUserInteractionEnabled:YES];
   // [self.view addGestureRecognizer:_singleFingerTap];
    
    [_FooerView setFrame:CGRectMake(0, _MainScrollView.frame.size.height-115, _AddClassClassTeacherNameTextField.frame.size.width+20, 180)];
    [_MainScrollView addSubview:_FooerView];
    
    
//    _addAnotherButton = [[UIButton alloc] initWithFrame:CGRectMake(10, _MainScrollView.frame.size.height-115, [[UIScreen mainScreen] bounds].size.width-(MenuWidth+10), 40)];
//    [_addAnotherButton setBackgroundColor:[UIColor clearColor]];
//    [_addAnotherButton addTarget:self action:@selector(adddata) forControlEvents:UIControlEventTouchUpInside];
//    [_MainScrollView addSubview:_addAnotherButton];
//    
//    _addAnotherLineLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, _MainScrollView.frame.size.height-115,[[UIScreen mainScreen] bounds].size.width-(MenuWidth+40),26)];
//    [_addAnotherLineLabel setBackgroundColor:[UIColor clearColor]];
//    [_addAnotherLineLabel setText:@"Add another time?"];
//    [_addAnotherLineLabel setTextColor:[UIColor blackColor]];
//    [_addAnotherLineLabel setTextAlignment:NSTextAlignmentLeft];
//    [_MainScrollView addSubview:_addAnotherLineLabel];
////
//    _checkBox =[[UIImageView alloc] initWithFrame:CGRectMake(0,7,15,15)];
//    _checkBox.image=[UIImage imageNamed:@"checkbox_normal"];
//    [_addAnotherButton addSubview:_checkBox];
////
//    _addLine=[[UILabel alloc]initWithFrame:CGRectMake(10, _MainScrollView.frame.size.height-70, [[UIScreen mainScreen] bounds].size.width-(MenuWidth+20), 1)];
//    [_addLine setBackgroundColor:[UIColor blackColor]];
//    [_MainScrollView addSubview:_addLine];
////
//    _SaveButton = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2-35, _MainScrollView.frame.size.height-50, ([[UIScreen mainScreen] bounds].size.width-MenuWidth)/2-10, 50)];
//    [_SaveButton setBackgroundColor:[UIColor blackColor]];
//    [_SaveButton setTitle:@"Save" forState:UIControlStateNormal];
//    [_SaveButton addTarget:self action:@selector(saveButton:) forControlEvents:UIControlEventTouchUpInside];
//    [_MainScrollView addSubview:_SaveButton];
//    
//    NSLog(@"_MainScrollView.contentSize.width ===%f ====== %f",_MainScrollView.contentSize.width,[[UIScreen mainScreen] bounds].size.width);
////
//    _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(10, _MainScrollView.frame.size.height-50,([[UIScreen mainScreen] bounds].size.width-MenuWidth)/2-10, 50)];
//    [_cancelButton setBackgroundColor:[UIColor blackColor]];
//    [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
//    [_cancelButton addTarget:self action:@selector(cancelButton:) forControlEvents:UIControlEventTouchUpInside];
//    [_MainScrollView addSubview:_cancelButton];
    
    segmentedControl1 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Sun", @"Mon", @"Tues",@"Wed",@"Th",@"Fri",@"Sat"]];
    [segmentedControl1 setBackgroundColor:[UIColor blackColor]];
    segmentedControl1.frame = CGRectMake(10, _ClassDaysLabel.layer.frame.origin.y+30, _MainScrollView.frame.size.width-60, 40);
    segmentedControl1.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    segmentedControl1.selectionStyle = HMSegmentedControlSelectionStyleBox;
    segmentedControl1.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    segmentedControl1.verticalDividerEnabled = YES;
    segmentedControl1.selectionIndicatorColor = [UIColor yellowColor];
    segmentedControl1.selectionIndicatorBoxOpacity = 0.8f;
    segmentedControl1.verticalDividerColor = [UIColor whiteColor];
    segmentedControl1.verticalDividerWidth = 1.0f;
    [segmentedControl1 setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        return attString;
    }];
    [segmentedControl1 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [_MainScrollView addSubview:segmentedControl1];
    [_MainScrollView bringSubviewToFront:segmentedControl1];
    
    [self segmentedControlChangedValue:segmentedControl1];
    
   /** SaveButton = [[UIButton alloc] initWithFrame:CGRectMake(10, _MainScrollView.frame.size.height-50, _MainScrollView.frame.size.width-20, 40)];
    [SaveButton setBackgroundColor:[UIColor greenColor]];
    [SaveButton setTitle:@"Save" forState:UIControlStateNormal];
    [_MainScrollView addSubview:SaveButton];
    
    segmentedControl1 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Sun", @"Mon", @"Tues",@"Wed",@"Th",@"Fri",@"Sat"]];
    [segmentedControl1 setBackgroundColor:[UIColor blackColor]];
    segmentedControl1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmentedControl1.frame = CGRectMake(0, 0, _MainScrollView.frame.size.width, 40);
    segmentedControl1.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    segmentedControl1.selectionStyle = HMSegmentedControlSelectionStyleBox;
    segmentedControl1.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    segmentedControl1.verticalDividerEnabled = YES;
    segmentedControl1.selectionIndicatorColor = [UIColor yellowColor];
    segmentedControl1.selectionIndicatorBoxOpacity = 0.8f;
    segmentedControl1.verticalDividerColor = [UIColor whiteColor];
    segmentedControl1.verticalDividerWidth = 1.0f;
    [segmentedControl1 setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        return attString;
    }];
    [segmentedControl1 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [_MainScrollView addSubview:segmentedControl1];
    [self segmentedControlChangedValue:segmentedControl1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ViewAddedWithResponce) name:AddViewNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ViewDeletedWithResponceWithObject:) name:DeleteViewNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextfiledStartEditingNotificationWithObject:) name:TextfiledStartEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextfiledEndEditingNotificationWithObject:) name:TextfiledEndEditingNotification object:nil];
    
    scrollViewBasicHeight   = _MainScrollView.contentSize.height;
    saveButtonYposition     = SaveButton.frame.origin.y;
    
    //Color did change block declaration
   
    NKOColorPickerDidChangeColorBlock colorDidChangeBlock = ^(UIColor *color){
        
        [UIView animateWithDuration:1.2 animations:^(void){
            
            NSLog(@"color ===> %@",[self hexStringFromColor:color]);
            [_ColorView setBackgroundColor:color];
            
        } completion:nil];
    };
    
    _colorPickerView = [[NKOColorPickerView alloc] initWithFrame:CGRectMake(80, _MainScrollView.frame.origin.y+100, _MainScrollView.contentSize.width, 390) color:[UIColor redColor] andDidChangeColorBlock:colorDidChangeBlock];
    [self.view addSubview:_colorPickerView];
    
    _ColorView = [[UIView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-60, _MainScrollView.frame.origin.y+60,40, 40)];
    [_ColorView setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:_ColorView];
    //[_ColorView setHidden:YES];
    [_colorPickerView setHidden:YES];
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openDateSelectionController:)];
    [singleFingerTap setNumberOfTapsRequired:1];
    [_ColorView setUserInteractionEnabled:YES];
    [_ColorView addGestureRecognizer:singleFingerTap];
    
    UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"popup test" message:@"popup test mesage" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [a show];
    **/
    
    _addAnotherButton = (UIButton *)[_FooerView viewWithTag:261];
    [_addAnotherButton addTarget:self action:@selector(adddata) forControlEvents:UIControlEventTouchUpInside];
    
//    [_MainScrollView bringSubviewToFront:_FooerView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ViewAddedWithResponce) name:AddViewNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ViewDeletedWithResponceWithObject:) name:DeleteViewNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextfiledStartEditingNotificationWithObject:) name:TextfiledStartEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextfiledEndEditingNotificationWithObject:) name:TextfiledEndEditingNotification object:nil];
}

-(void)OpendatePickerDateOption
{
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        NSLog(@"Successfully selected date: %@", ((UIDatePicker *)controller.contentView).date);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd-yyyy"];
        NSString *selectedDate = [formatter stringFromDate:((UIDatePicker *)controller.contentView).date];
        
        if (_DateSelectiontype == dateSelectiontypestartdate) {
            _AddClassClassStartDateTextField.text = selectedDate;
        } else if (_DateSelectiontype == dateSelectiontypeenddate) {
            _AddClassClassEndDateTextField.text = selectedDate;
        }
        _DateSelectiontype = dateSelectiontypenone;
    }];
    
    RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        _DateSelectiontype = dateSelectiontypenone;
    }];
    
    RMDateSelectionViewController *dateSelectionController = [RMDateSelectionViewController actionControllerWithStyle:RMActionControllerStyleWhite selectAction:selectAction andCancelAction:cancelAction];
    dateSelectionController.datePicker.minimumDate = [NSDate date];
    dateSelectionController.title = (_DateSelectiontype == dateSelectiontypestartdate)?@"Start Date":@"End Date";
    dateSelectionController.datePicker.datePickerMode = UIDatePickerModeDate;
    
    [_Maindelegate.window.rootViewController presentViewController:dateSelectionController animated:YES completion:nil];
}

-(void)OpendatePickerOption
{
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        NSLog(@"Successfully selected date: %@", ((UIDatePicker *)controller.contentView).date);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd-yyyy"];
        NSString *selectedDate = [formatter stringFromDate:((UIDatePicker *)controller.contentView).date];
        
        if (_DateSelectiontype == dateSelectiontypestartdate) {
            _AddClassClassStartDateTextField.text = selectedDate;
        } else if (_DateSelectiontype == dateSelectiontypeenddate) {
            _AddClassClassEndDateTextField.text = selectedDate;
        }
        _DateSelectiontype = dateSelectiontypenone;
    }];
    
    RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        _DateSelectiontype = dateSelectiontypenone;
    }];
    
    RMDateSelectionViewController *dateSelectionController = [RMDateSelectionViewController actionControllerWithStyle:RMActionControllerStyleWhite selectAction:selectAction andCancelAction:cancelAction];
    dateSelectionController.datePicker.minimumDate = [NSDate date];
    dateSelectionController.title = (_DateSelectiontype == dateSelectiontypestartdate)?@"Start Date":@"End Date";
    dateSelectionController.datePicker.datePickerMode = UIDatePickerModeDate;
    
    [_Maindelegate.window.rootViewController presentViewController:dateSelectionController animated:YES completion:nil];
}

#pragma mark - UITextfield Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _AddClassClassStartDateTextField) {
        _DateSelectiontype = dateSelectiontypestartdate;
        [self OpendatePickerOption];
        return NO;
    } else if (textField == _AddClassClassEndDateTextField) {
        _DateSelectiontype = dateSelectiontypeenddate;
        [self OpendatePickerOption];
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    for (id AllSubview in [_MainScrollView subviews]) {
        if ([AllSubview isKindOfClass:[UITextField class]]) {
            UITextField *LocalObject = (UITextField *)AllSubview;
            [LocalObject resignFirstResponder];
        }
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    for (id AllSubview in [_MainScrollView subviews]) {
        if ([AllSubview isKindOfClass:[UITextField class]]) {
            UITextField *LocalObject = (UITextField *)AllSubview;
            [LocalObject resignFirstResponder];
        }
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    for (id AllSubview in [_MainScrollView subviews]) {
        if ([AllSubview isKindOfClass:[UITextField class]]) {
            UITextField *LocalObject = (UITextField *)AllSubview;
            [LocalObject resignFirstResponder];
        }
    }
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    if (IscolorPickerVisiable) {
        [UIView animateWithDuration:1.2 animations:^(void){
            [self.view removeGestureRecognizer:_singleFingerTap];
            [_colorPickerView setHidden:YES];
            IscolorPickerVisiable = NO;
        } completion:nil];
    }
}

-(void)OpenColorPicker
{
    if (IscolorPickerVisiable) {
        [UIView animateWithDuration:1.2 animations:^(void){
            [self.view removeGestureRecognizer:_singleFingerTap];
            [_colorPickerView setHidden:YES];
            IscolorPickerVisiable = NO;
        } completion:nil];
    } else {
        [UIView animateWithDuration:1.2 animations:^(void){
            [self.view addGestureRecognizer:_singleFingerTap];
            [_colorPickerView setHidden:NO];
            IscolorPickerVisiable = YES;
        } completion:nil];
    }
}

- (IBAction)openDateSelectionController:(id)sender {
    //Create select action
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        NSLog(@"Successfully selected date: %@", ((UIDatePicker *)controller.contentView).date);
    }];
    
    //Create cancel action
    RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        NSLog(@"Date selection was canceled");
    }];
    
    //Create date selection view controller
    RMDateSelectionViewController *dateSelectionController = [RMDateSelectionViewController actionControllerWithStyle:RMActionControllerStyleWhite selectAction:selectAction andCancelAction:cancelAction];
    dateSelectionController.title = @"Test";
    dateSelectionController.datePicker.datePickerMode = UIDatePickerModeDate;
    dateSelectionController.message = @"This is a test message.\nPlease choose a date and press 'Select' or 'Cancel'.";
    
    AppDelegate *Maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //Now just present the date selection controller using the standard iOS presentation method
    [Maindelegate.window.rootViewController presentViewController:dateSelectionController animated:YES completion:nil];
    
    //[self.navigationController pushViewController:dateSelectionController animated:YES];
}

- (NSString *)hexStringFromColor:(UIColor *)color
{
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

#pragma mark - Segment Control Delegate

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl{
    
    //if([self CheckTimeValidation]) {
        switch (segmentedControl.selectedSegmentIndex)
        {
            case 0:
                _Weakdaytype = weakdaytypesunday;
                break;
            case 1:
                _Weakdaytype = weakdaytypemonday;
                break;
            case 2:
                _Weakdaytype = weakdaytypetuesday;
                break;
            case 3:
                _Weakdaytype = weakdaytypewednesday;
                break;
            case 4:
                _Weakdaytype = weakdaytypethirsday;
                break;
            case 5:
                _Weakdaytype = weakdaytypefriday;
                break;
            case 6:
                _Weakdaytype = weakdaytypesaturday;
                break;
        }
        
        for (id AllsubView in [_MainScrollView subviews])
        {
            if ([AllsubView isKindOfClass:[AddMoreView class]])
            {
                [AllsubView removeFromSuperview];
                [_MainScrollView setContentSize:CGSizeMake(_MainScrollView.contentSize.width,_MainScrollView.contentSize.height-AddmoreViewHeight)];
            }
        }
        
        if ([[_GlobalTagArray objectAtIndex:_Weakdaytype] count]>0)
        {
            for (int rr = 0 ; rr<[[_GlobalTagArray objectAtIndex:_Weakdaytype] count]; rr++)
            {
                
                NSMutableArray *DataObjectArray = [_GlobalTagArray objectAtIndex:_Weakdaytype];
                
                _AditionType = aditionTypeSegment;
                
                AddMoreView *moreView = [[AddMoreView alloc] initWithFrame:CGRectMake(5, _MainScrollView.contentSize.height-(AddmoreViewHeight+80), _MainScrollView.contentSize.width-5, AddmoreViewHeight-15) WithTag:[[DataObjectArray objectAtIndex:rr] intValue] WithDeleteButtonTag:(int)DeleteButtonAddTag WithSelecter:@selector(deletedata:)];
                [_MainScrollView addSubview:moreView];
                
                CGRect frame         = _FooerView.frame;
                frame.origin.y       = _MainScrollView.contentSize.height-AddmoreViewHeight;
                _FooerView.frame     = frame;
                
                [_MainScrollView setContentSize:CGSizeMake(_MainScrollView.contentSize.width,_MainScrollView.contentSize.height+AddmoreViewHeight)];
            }
        }
        _AditionType = aditionTypenormal;
//    } else {
//        UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:AlertTitle message:@"Start time and end time not valied" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [ErrorAlert show];
//    }
}

- (void)uisegmentedControlChangedValue:(UISegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld", (long)segmentedControl.selectedSegmentIndex);
}

-(void)CustomizeHeaderwithTitle:(NSString *)Title WithFontName:(NSString *)FontName WithFontSize:(float)Size withButton:(BOOL)button withSelecter:(SEL)selecter WithButtonBgImage:(NSString *)WithButtonBgImage
{
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(MenuWidth, 0, [[UIScreen mainScreen] bounds].size.width-MenuWidth, HeaderHeight)];
    [HeaderView setBackgroundColor:Constant.ColorSPAYellowColor];
    HeaderView.layer.masksToBounds = NO;
    HeaderView.layer.shadowOffset = CGSizeMake(0, 1);
    HeaderView.layer.shadowRadius = 10;
    HeaderView.layer.shadowOpacity = 0.4;
    [self.view addSubview:HeaderView];
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, HeaderView.layer.frame.size.width-45, HeaderView.layer.frame.size.height-10)];
    [TitleLabel setBackgroundColor:[UIColor clearColor]];
    [TitleLabel setTextColor:[UIColor whiteColor]];
    [TitleLabel setText:Title];
    [TitleLabel setTextAlignment:NSTextAlignmentLeft];
    [TitleLabel setFont:[UIFont fontWithName:FontName size:Size]];
    [HeaderView addSubview:TitleLabel];
    
    if (button)
    {
        UIButton *HeaderButton = [[UIButton alloc] initWithFrame:CGRectMake(HeaderView.layer.frame.size.width-45, 24, 40, 40)];
        [HeaderButton setBackgroundColor:[UIColor clearColor]];
        [HeaderButton setBackgroundImage:[UIImage imageNamed:WithButtonBgImage] forState:UIControlStateNormal];
        [HeaderButton setBackgroundImage:[UIImage imageNamed:WithButtonBgImage] forState:UIControlStateApplication];
        [HeaderButton setBackgroundImage:[UIImage imageNamed:WithButtonBgImage] forState:UIControlStateHighlighted];
        [HeaderButton setBackgroundImage:[UIImage imageNamed:WithButtonBgImage] forState:UIControlStateSelected];
        [HeaderButton addTarget:self action:@selector(adddata) forControlEvents:UIControlEventTouchUpInside];
        [HeaderView addSubview:HeaderButton];
    }
}

-(void)deletedataWithTag:(int)TagVal
{
    _Buttonrepostiontype = buttonrepostiontypeup;
    
    NSLog(@"ObjectArray after deletion %@",_GlobalTagArray);
    
    for (id AllsubView in [_MainScrollView subviews])
    {
        if ([AllsubView isKindOfClass:[AddMoreView class]])
        {
            AddMoreView *AddmoreView = (AddMoreView *)AllsubView;
            if ((int)AddmoreView.tag > TagVal)
            {
                CGRect frame        = AddmoreView.frame;
                frame.origin.y      = frame.origin.y-AddmoreViewHeight;
                AddmoreView.frame   = frame;
            }
        }
    }
    [self RepositioningScroollView];
}

-(void)deletedata:(UIButton *)Selecter
{
    _Buttonrepostiontype = buttonrepostiontypeup;
    
    NSMutableArray *ObjectArray = [_GlobalTagArray objectAtIndex:_Weakdaytype];
    [ObjectArray removeObject:[NSString stringWithFormat:@"%d",(int)Selecter.tag-(int)DeleteButtonAddTag]];
    
    NSLog(@"ObjectArray after deletion %@",_GlobalTagArray);
    
    for (id AllsubView in [_MainScrollView subviews])
    {
        if ([AllsubView isKindOfClass:[AddMoreView class]])
        {
            AddMoreView *AddmoreView = (AddMoreView *)AllsubView;
            if ((int)AddmoreView.tag > (int)Selecter.tag-(int)DeleteButtonAddTag)
            {
                CGRect frame        = AddmoreView.frame;
                frame.origin.y      = frame.origin.y-AddmoreViewHeight;
                AddmoreView.frame   = frame;
            }
        }
    }
    [self RepositioningScroollView];
}

-(void)adddata
{
    if ([self CheckTimeValidation]) {
        _Buttonrepostiontype = buttonrepostiontypedown;
        [self RepositioningScroollView];
    } else {
        UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:AlertTitle message:@"Start time and end time not valied" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [ErrorAlert show];
    }
}

-(BOOL)CheckTimeValidation
{
//    for (id AllSubview in [_MainScrollView subviews]) {
//        if ([AllSubview isKindOfClass:[AddMoreView class]]) {
//            
//            AddMoreView *LocalViewObject = (AddMoreView *)AllSubview;
//            UITextField *StartDateTextField = (UITextField *)[LocalViewObject viewWithTag:165];
//            UITextField *EndDateTextField = (UITextField *)[LocalViewObject viewWithTag:166];
//            
//            NSString *startTimeString = StartDateTextField.text;
//            NSString *endTimeString = EndDateTextField.text;
//            
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"hh:mm a"];
//            NSString *nowTimeString = [formatter stringFromDate:[NSDate date]];
//            
//            int startTime   = [self minutesSinceMidnight:[formatter dateFromString:startTimeString]];
//            int endTime     = [self minutesSinceMidnight:[formatter dateFromString:endTimeString]];
//            int nowTime     = [self minutesSinceMidnight:[formatter dateFromString:nowTimeString]];;
//            
//            NSLog(@"startTime ==> %d  endTime ==> %d nowTime ==> %d",startTime,endTime,nowTime);
//            
//            if (startTime == endTime) {
//                ISValidated = NO;
//            }
//            
////            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
////            [formatter setDateFormat:@"hh:mm a"];
////            NSString *nowTimeString = [formatter stringFromDate:[NSDate date]];
////            
////            int startTime   = [self minutesSinceMidnight:[formatter dateFromString:startTimeString]];
////            int endTime     = [self minutesSinceMidnight:[formatter dateFromString:endTimeString]];
////            int nowTime     = [self minutesSinceMidnight:[formatter dateFromString:nowTimeString]];;
////            
////            if (startTime <= nowTime && nowTime <= endTime)
////            {
////                NSLog(@"Time is between");
////                ISValidated = YES;
////            }
////            else {
////                NSLog(@"Time is not between");
////                ISValidated = NO;
////            }
//        }
//    }
    ISValidated=YES;
    return (ISValidated)?YES:NO;
}

-(void)RepositioningScroollView
{
    if (_Buttonrepostiontype == buttonrepostiontypedown)
    {
        [_MainScrollView addSubview:[self AddMoreViewWithYpostion:_MainScrollView.contentSize.height-(AddmoreViewHeight+85)]];
    }
    
    CGRect frame_FooterView         = _FooerView.frame;
    frame_FooterView.origin.y       = (_Buttonrepostiontype == buttonrepostiontypedown)?frame_FooterView.origin.y+AddmoreViewHeight:frame_FooterView.origin.y-AddmoreViewHeight;
    _FooerView.frame     = frame_FooterView;
    
     [_MainScrollView setContentSize:CGSizeMake(_MainScrollView.frame.size.width, (_Buttonrepostiontype == buttonrepostiontypedown)?(_MainScrollView.contentSize.height+AddmoreViewHeight):(_MainScrollView.contentSize.height-AddmoreViewHeight))];
    
    /**CGRect frame_addAnotherButton         = _addAnotherButton.frame;
    frame_addAnotherButton.origin.y       = (_Buttonrepostiontype == buttonrepostiontypedown)?frame_addAnotherButton.origin.y+AddmoreViewHeight:frame_addAnotherButton.origin.y-AddmoreViewHeight;
    _addAnotherButton.frame     = frame_addAnotherButton;
    
    CGRect frame_addAnotherLineLabel         = _addAnotherLineLabel.frame;
    frame_addAnotherLineLabel.origin.y       = (_Buttonrepostiontype == buttonrepostiontypedown)?frame_addAnotherLineLabel.origin.y+AddmoreViewHeight:frame_addAnotherLineLabel.origin.y-AddmoreViewHeight;
    _addAnotherLineLabel.frame     = frame_addAnotherLineLabel;
    
    CGRect frame_checkBox         = _checkBox.frame;
    frame_checkBox.origin.y       = (_Buttonrepostiontype == buttonrepostiontypedown)?frame_checkBox.origin.y+AddmoreViewHeight:frame_checkBox.origin.y-AddmoreViewHeight;
    _checkBox.frame     = frame_checkBox;
    
    CGRect frame_addLine         = _addLine.frame;
    frame_addLine.origin.y       = (_Buttonrepostiontype == buttonrepostiontypedown)?frame_addLine.origin.y+AddmoreViewHeight:frame_addLine.origin.y-AddmoreViewHeight;
    _addLine.frame     = frame_addLine;
    
    CGRect frame_SaveButton         = _SaveButton.frame;
    frame_SaveButton.origin.y       = (_Buttonrepostiontype == buttonrepostiontypedown)?frame_SaveButton.origin.y+AddmoreViewHeight:frame_SaveButton.origin.y-AddmoreViewHeight;
    _SaveButton.frame     = frame_SaveButton;
    
    CGRect frame_cancelButton         = _cancelButton.frame;
    frame_cancelButton.origin.y       = (_Buttonrepostiontype == buttonrepostiontypedown)?frame_cancelButton.origin.y+AddmoreViewHeight:frame_cancelButton.origin.y-AddmoreViewHeight;
    _cancelButton.frame     = frame_cancelButton;
     **/
    
    _Buttonrepostiontype = buttonrepostiontypenone;
    
}

-(UIView *)AddMoreViewWithYpostion:(float)Yposition
{
    AddMoreView *moreView = [[AddMoreView alloc] initWithFrame:CGRectMake(0, Yposition, _MainScrollView.contentSize.width, AddmoreViewHeight-15) WithTag:(int)addMoreViewTag WithDeleteButtonTag:(int)DeleteButtonAddTag WithSelecter:@selector(deletedata:)];
    return moreView;
}

-(void)ViewAddedWithResponce
{
    
    if (_AditionType == aditionTypenormal) {
        
        NSMutableArray *ObjectArray = [_GlobalTagArray objectAtIndex:_Weakdaytype];
        [ObjectArray addObject:[NSString stringWithFormat:@"%d",addMoreViewTag]];
        
         NSLog(@"ObjectArray after addition %@",_GlobalTagArray);
        
        addMoreViewTag = addMoreViewTag +1;
    } else {
        _AditionType = aditionTypenormal;
        NSLog(@"ObjectArray after addition %@",_GlobalTagArray);
    }
}

-(void)ViewDeletedWithResponceWithObject:(NSNotification*)Obj
{
    UIButton *ObjectButton = (UIButton *)Obj.object;
    [self deletedata:ObjectButton];
}

-(int) minutesSinceMidnight:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    return 60 * (int)[components hour] + (int)[components minute];
}

-(void)startTimeMathodWithTextField:(NSArray *)SplitedArray
{
    AddMoreView *AddmoreView = (AddMoreView *)[_MainScrollView viewWithTag:[[SplitedArray objectAtIndex:0] intValue]];
    [AddmoreView setBackgroundColor:[UIColor orangeColor]];
    UITextField *StartDateTextField = (UITextField *)[AddmoreView viewWithTag:165];
    UITextField *EndDateTextField = (UITextField *)[AddmoreView viewWithTag:166];
    _MainScrollView.backgroundColor = [UIColor redColor];
    
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm a"];
        NSString *selectedDate = [formatter stringFromDate:((UIDatePicker *)controller.contentView).date];
        if ([[SplitedArray objectAtIndex:1] intValue] == 165) { [StartDateTextField setText:selectedDate]; } else { [EndDateTextField setText:selectedDate]; };
        
        NSLog(@"StartDateTextField text %@ and EndDateTextField text %@",StartDateTextField.text,EndDateTextField.text);
        
        NSString *startTimeString = StartDateTextField.text;//@"08:00 AM";
        NSString *endTimeString = EndDateTextField.text;//@"06:00 PM";
        
        NSString *nowTimeString = [formatter stringFromDate:[NSDate date]];
        
        int startTime   = [self minutesSinceMidnight:[formatter dateFromString:startTimeString]];
        int endTime     = [self minutesSinceMidnight:[formatter dateFromString:endTimeString]];
        int nowTime     = [self minutesSinceMidnight:[formatter dateFromString:nowTimeString]];;
        
        if (startTime <= nowTime && nowTime <= endTime)
        {
            NSLog(@"Time is between");
            ISValidated = YES;
        }
        else {
            NSLog(@"Time is not between");
            ISValidated = NO;
        }
    }];
    
    RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        NSLog(@"Date selection was canceled");
    }];
    
    RMDateSelectionViewController *dateSelectionController = [RMDateSelectionViewController actionControllerWithStyle:RMActionControllerStyleWhite selectAction:selectAction andCancelAction:cancelAction];
    dateSelectionController.title = @"Start Time";
    dateSelectionController.datePicker.datePickerMode = UIDatePickerModeTime;
    AppDelegate *Maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [Maindelegate.window.rootViewController presentViewController:dateSelectionController animated:YES completion:nil];
}

-(void)endTimeMathodWithTextField:(UITextField *)EndTimeTextField
{
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        NSLog(@"Successfully selected date: %@", ((UIDatePicker *)controller.contentView).date);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm a"];
        NSString *selectedDate = [formatter stringFromDate:((UIDatePicker *)controller.contentView).date];
        [EndTimeTextField setText:selectedDate];
    }];
    
    RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        NSLog(@"Date selection was canceled");
    }];
    
    RMDateSelectionViewController *dateSelectionController = [RMDateSelectionViewController actionControllerWithStyle:RMActionControllerStyleWhite selectAction:selectAction andCancelAction:cancelAction];
    dateSelectionController.title = @"End Time";
    dateSelectionController.datePicker.datePickerMode = UIDatePickerModeTime;
    AppDelegate *Maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [Maindelegate.window.rootViewController presentViewController:dateSelectionController animated:YES completion:nil];
}

-(void)TextfiledStartEditingNotificationWithObject:(NSNotification*)Obj
{
    NSArray *SplitedArray = [Obj.object componentsSeparatedByString:@"||"];
    [self startTimeMathodWithTextField:SplitedArray];
    
//    AddMoreView *AddmoreView = (AddMoreView *)[_MainScrollView viewWithTag:[[SplitedArray objectAtIndex:0] intValue]];
//    UITextField *StartDateTextField = (UITextField *)[AddmoreView viewWithTag:165];
//    UITextField *EndDateTextField = (UITextField *)[AddmoreView viewWithTag:166];
//    if ([[SplitedArray objectAtIndex:1] intValue] == 165) {
//        [self startTimeMathodWithTextField:SplitedArray];
//    } else {
//        [self endTimeMathodWithTextField:EndDateTextField];
//    }
}

-(void)TextfiledEndEditingNotificationWithObject:(NSNotification*)Obj
{
    NSArray *SplitedArray = [Obj.object componentsSeparatedByString:@"||"];
    NSLog(@"SplitedArray ==> %@",SplitedArray);
    
    AddMoreView *AddmoreView = (AddMoreView *)[_MainScrollView viewWithTag:[Obj.object intValue]];
    UITextField *StartDateTextField = (UITextField *)[AddmoreView viewWithTag:165];
    UITextField *EndDateTextField = (UITextField *)[AddmoreView viewWithTag:166];
    
    NSLog(@"StartDateTextField taxt  => %@",StartDateTextField.text);
    NSLog(@"EndDateTextField taxt  => %@",EndDateTextField.text);
    
    //UITextField *EndDateTextField = (UITextField *)[AddmoreView viewWithTag:166];
    //[UIView animateWithDuration:1.2 animations:^{_MainScrollView.contentOffset = CGPointMake(0, AddmoreView.frame.origin.y-500);}];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:AddViewNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:DeleteViewNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:TextfiledStartEditingNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:TextfiledEndEditingNotification];
}


@end
