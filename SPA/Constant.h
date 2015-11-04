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

/**
 * SPASourceConfig const
 */

#define kConfigVersionKey @"version"
#define kConfigBuildKey @"build"
#define kConfigTheMovieDbHostKey @"themoviedb_host"
#define kConfigApiKey @"api_key"
#define kConfigLoginKey @"login_parameters"

@interface Constant : NSObject

+(ViewController *)LandingController;
+(LoginViewController *)LoginViewController;
+(SignupController *)SignupController;
+(ForgetPasswordControllerViewController *)ForgetPasswordControllerViewController;
+(EditProfileViewController *)EditProfileViewController;
+(ClassListViewController *)ClassListViewController;
+(AddClassViewController *)AddClassViewController;
+(ScheduleViewController *)ScheduleViewController;
+(AddScheduleViewController *)AddScheduleViewController;
+(TaskListViewController *)TaskListViewController;
+(AddTaskViewController *)AddTaskViewController;
+(AgendaListDayViewController *)AgendaListDayViewController;
+(AgendaListFiveDayViewController *)AgendaListFiveDayViewController;
+(AgendaListMonthViewController *)AgendaListMonthViewController;
+(ClassTasksViewController *)ClassTasksViewController;
+(MaterialsListViewController *)MaterialsListViewController;
+(StudentsViewController *)StudentsViewController;
+(AlertStudentsViewController *)AlertStudentsViewController;
+(ClassInfoViewController *)ClassInfoViewController;

+(NSString *)FontMyriadProSemiboldIt;
+(NSString *)FontMyriadProBoldIt;
+(NSString *)FontMyriadProSemibold;
+(NSString *)FontMyriadProBold;
+(NSString *)FontMyriadProBoldCond;
+(NSString *)FontMyriadProRegular;
+(NSString *)FontMyriadProIt;
+(NSString *)FontMyriadProCondIt;
+(NSString *)FontMyriadProCond;

+(NSString *)FontHelveticaBold;
+(NSString *)FontHelvetica;
+(NSString *)FontHelveticaLightOblique;
+(NSString *)FontHelveticaOblique;
+(NSString *)FontHelveticaBoldOblique;
+(NSString *)FontHelveticaLight;

+(NSString *)FontRobotoBold;
+(NSString *)FontRobotoRegular;
+(NSString *)FontRobotoMedium;

+(UIColor *)ColorSPAWhiteColor;
+(UIColor *)ColorSPABlackColor;
+(UIColor *)ColorSPAGreenColor;
+(UIColor *)ColorSPAYellowColor;

@end
