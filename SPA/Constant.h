//
//  Constant.h
//  SPA
//
//  Created by Santanu Das Adhikary on 16/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "LoginViewController.h"
#import "SignupController.h"
#import "ForgetPasswordControllerViewController.h"
#import "EditProfileViewController.h"
#import "ClassListViewController.h"
#import "AddClassViewController.h"
#import "ScheduleViewController.h"
#import "AddScheduleViewController.h"
#import "TaskListViewController.h"
#import "AddTaskViewController.h"
#import "AgendaListDayViewController.h"
#import "AgendaListFiveDayViewController.h"
#import "AgendaListMonthViewController.h"
#import "ClassTasksViewController.h"
#import "MaterialsListViewController.h"
#import "StudentsViewController.h"
#import "AlertStudentsViewController.h"
#import "ClassInfoViewController.h"

@interface Constant : NSObject

/**
 Define all viewcontrollers
 */

/**
 @return LandingController
 */
+(ViewController *)LandingController;
/**
 @return LoginViewController
 */
+(LoginViewController *)LoginViewController;
/**
 @return SignupController
 */
+(SignupController *)SignupController;
/**
 @return ForgetPasswordControllerViewController
 */
+(ForgetPasswordControllerViewController *)ForgetPasswordControllerViewController;
/**
 @return EditProfileViewController
 */
+(EditProfileViewController *)EditProfileViewController;
/**
 @return ClassListViewController
 */
+(ClassListViewController *)ClassListViewController;
/**
 @return AddClassViewController
 */
+(AddClassViewController *)AddClassViewController;
/**
 @return ScheduleViewController
 */
+(ScheduleViewController *)ScheduleViewController;
/**
 @return AddScheduleViewController
 */
+(AddScheduleViewController *)AddScheduleViewController;
/**
 @return TaskListViewController
 */
+(TaskListViewController *)TaskListViewController;
/**
 @return AddTaskViewController
 */
+(AddTaskViewController *)AddTaskViewController;
/**
 @return AgendaListDayViewController
 */
+(AgendaListDayViewController *)AgendaListDayViewController;
/**
 @return AgendaListFiveDayViewController
 */
+(AgendaListFiveDayViewController *)AgendaListFiveDayViewController;
/**
 @return AgendaListMonthViewController
 */
+(AgendaListMonthViewController *)AgendaListMonthViewController;
/**
 @return ClassTasksViewController
 */
+(ClassTasksViewController *)ClassTasksViewController;
/**
 @return MaterialsListViewController
 */
+(MaterialsListViewController *)MaterialsListViewController;
/**
 @return StudentsViewController
 */
+(StudentsViewController *)StudentsViewController;
/**
 @return AlertStudentsViewController
 */
+(AlertStudentsViewController *)AlertStudentsViewController;
/**
 @return ClassInfoViewController
 */
+(ClassInfoViewController *)ClassInfoViewController;


/*
 Define all the fonts for the application
 */

/**
 @return MyriadPro-Semibold-It
 */
+(NSString *)FontMyriadProSemiboldIt;
/**
 @return MyriadPro-Bold-It
 */
+(NSString *)FontMyriadProBoldIt;
/**
 @return MyriadPro-Semibold
 */
+(NSString *)FontMyriadProSemibold;
/**
 @return MyriadPro-Bold
 */
+(NSString *)FontMyriadProBold;
/**
 @return MyriadPro-Bold-Cond
 */
+(NSString *)FontMyriadProBoldCond;
/**
 @return MyriadPro-Regular
 */
+(NSString *)FontMyriadProRegular;
/**
 @return MyriadPro-It
 */
+(NSString *)FontMyriadProIt;
/**
 @return MyriadPro-CondIt
 */
+(NSString *)FontMyriadProCondIt;
/**
 @return MyriadPro-Cond
 */
+(NSString *)FontMyriadProCond;
/**
 @return Helvetica-Bold
 */
+(NSString *)FontHelveticaBold;
/**
 @return Helvetica
 */
+(NSString *)FontHelvetica;
/**
 @return Helvetica-Light-Oblique
 */
+(NSString *)FontHelveticaLightOblique;
/**
 @return Helvetica-Oblique
 */
+(NSString *)FontHelveticaOblique;
/**
 @return Helvetica-Bold-Oblique
 */
+(NSString *)FontHelveticaBoldOblique;
/**
 @return Helvetica-Light
 */
+(NSString *)FontHelveticaLight;
/**
 @return Roboto-Bold
 */
+(NSString *)FontRobotoBold;
/**
 @return Roboto-Regular
 */
+(NSString *)FontRobotoRegular;
/**
 @return Roboto-Medium
 */
+(NSString *)FontRobotoMedium;


/**
 Define all the color
 */

/**
 @return White Color
 */
+(UIColor *)ColorSPAWhiteColor;
/**
 @return Black Color
 */
+(UIColor *)ColorSPABlackColor;
/**
 @return Green Color
 */
+(UIColor *)ColorSPAGreenColor;
/**
 @return Yellow Color
 */
+(UIColor *)ColorSPAYellowColor;

+ (BOOL) ScreenOfPlatform4m;
+ (BOOL) ScreenOfPlatform5e;
+ (BOOL) DeviceIsIphoneFive;
+ (BOOL) IsConnectedToInternet;
+ (BOOL) ShowLastExecutedMethod;

+ (NSString*) LastExecutedMethod;

+(NSString *)CleanTextField:(NSString *)TextfieldName;
+(BOOL)ValidateEmail:(NSString *)EmailValue;
-(BOOL)ValidateSpecialCharacter:(NSString *)DataValue;
+(BOOL)validatePhone:(NSString*)phone;
-(NSDictionary *)executeFetch:(NSString *)query;
-(NSString *)CallURLForServerReturn: (NSMutableDictionary *)TotalData URL:(NSString *)UrlType;
- (NSString *) stripTags:(NSString *)s;
-(BOOL)ValidateTextField:(NSString *)TextFieldValue;
-(NSDictionary *)GenerateParamValueForSubmit:(NSArray *)ParamArray FieldArray:(NSArray *)FieldArray;

+(NSString *)EntityForUser;

@end
