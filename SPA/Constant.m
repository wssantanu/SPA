//
//  Constant.m
//  SPA
//
//  Created by Santanu Das Adhikary on 16/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "Constant.h"

/**
 * @key define for MyriadPro font
 **/

#define kConfigFontMyriadProSemiboldItKey @"MyriadPro-SemiboldIt"
#define kConfigFontMyriadProBoldItKey @"MyriadPro-BoldIt"
#define kConfigFontMyriadProSemiboldKey @"MyriadPro-Semibold"
#define kConfigFontMyriadProBoldKey @"MyriadPro-Bold"
#define kConfigFontMyriadProBoldCondKey @"MyriadPro-BoldCond"
#define kConfigFontMyriadProRegularKey @"MyriadPro-Regular"
#define kConfigFontMyriadProBoldCondItKey @"MyriadPro-BoldCondIt"
#define kConfigFontMyriadProItKey @"MyriadPro-It"
#define kConfigFontMyriadProCondItKey @"MyriadPro-CondIt"
#define kConfigFontMyriadProCondKey @"MyriadPro-Cond"

/**
 * @key define for Helvetica font
 **/

#define kConfigFontHelveticaBoldKey @"Helvetica-Bold"
#define kConfigFontHelveticaKey @"Helvetica"
#define kConfigFontHelveticaLightObliqueKey @"Helvetica-LightOblique"
#define kConfigFontHelveticaObliqueKey @"Helvetica-Oblique"
#define kConfigFontHelveticaBoldObliqueKey @"Helvetica-BoldOblique"
#define kConfigFontHelveticaLightKey @"Helvetica-Light"

/**
 * @key define for Roboto font
 **/

#define kConfigFontRobotoBoldKey @"Roboto-Bold"
#define kConfigFontRobotoRegularKey @"Roboto-Regular"
#define kConfigFontRobotoMediumKey @"Roboto-Medium"

/**
 @key define for color
 */

#define kConfigFontSPAWhiteKey @"0xFFFFFF"
#define kConfigFontSPABlackKey @"0x000000"
#define kConfigFontSPAGreenKey @"0x52a63d"
#define kConfigFontSPAYellowKey @"0xF2BA27"

@implementation Constant

+(ViewController *)LandingController {
    return [[ViewController alloc] initWithNibName:@"ViewController" bundle:[NSBundle mainBundle]];
}
+(LoginViewController *)LoginViewController {
    return [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
}
+(SignupController *)SignupController {
    return [[SignupController alloc] initWithNibName:@"SignupController" bundle:[NSBundle mainBundle]];
}
+(ForgetPasswordControllerViewController *)ForgetPasswordControllerViewController {
    return [[ForgetPasswordControllerViewController alloc] initWithNibName:@"ForgetPasswordControllerViewController" bundle:[NSBundle mainBundle]];
}
+(EditProfileViewController *)EditProfileViewController {
    return [[EditProfileViewController alloc] initWithNibName:@"EditProfileViewController" bundle:[NSBundle mainBundle]];
}
+(ClassListViewController *)ClassListViewController {
    return [[ClassListViewController alloc] initWithNibName:@"ClassListViewController" bundle:[NSBundle mainBundle]];
}
+(AddClassViewController *)AddClassViewController {
    return [[AddClassViewController alloc] initWithNibName:@"AddClassViewController" bundle:[NSBundle mainBundle]];
}
+(ScheduleViewController *)ScheduleViewController {
    return [[ScheduleViewController alloc] initWithNibName:@"ScheduleViewController" bundle:[NSBundle mainBundle]];
}
+(AddScheduleViewController *)AddScheduleViewController {
    return [[AddScheduleViewController alloc] initWithNibName:@"AddScheduleViewController" bundle:[NSBundle mainBundle]];
}
+(TaskListViewController *)TaskListViewController {
    return [[TaskListViewController alloc] initWithNibName:@"TaskListViewController" bundle:[NSBundle mainBundle]];
}
+(AddTaskViewController *)AddTaskViewController {
    return [[AddTaskViewController alloc] initWithNibName:@"AddTaskViewController" bundle:[NSBundle mainBundle]];
}
+(AgendaListDayViewController *)AgendaListDayViewController {
    return [[AgendaListDayViewController alloc] initWithNibName:@"AgendaListDayViewController" bundle:[NSBundle mainBundle]];
}
+(AgendaListFiveDayViewController *)AgendaListFiveDayViewController {
    return [[AgendaListFiveDayViewController alloc] initWithNibName:@"AgendaListFiveDayViewController" bundle:[NSBundle mainBundle]];
}
+(AgendaListMonthViewController *)AgendaListMonthViewController {
    return [[AgendaListMonthViewController alloc] initWithNibName:@"AgendaListMonthViewController" bundle:[NSBundle mainBundle]];
}
+(ClassTasksViewController *)ClassTasksViewController{
    return [[ClassTasksViewController alloc] initWithNibName:@"ClassTasksViewController" bundle:[NSBundle mainBundle]];
}
+(MaterialsListViewController *)MaterialsListViewController {
    return [[MaterialsListViewController alloc] initWithNibName:@"MaterialsListViewController" bundle:[NSBundle mainBundle]];
}
+(StudentsViewController *)StudentsViewController {
    return [[StudentsViewController alloc] initWithNibName:@"StudentsViewController" bundle:[NSBundle mainBundle]];
}
+(AlertStudentsViewController *)AlertStudentsViewController {
    return [[AlertStudentsViewController alloc] initWithNibName:@"AlertStudentsViewController" bundle:[NSBundle mainBundle]];
}
+(ClassInfoViewController *)ClassInfoViewController {
    return [[ClassInfoViewController alloc] initWithNibName:@"ClassInfoViewController" bundle:[NSBundle mainBundle]];
}

/**
 @return Font name as string
 */

+(NSString *)FontMyriadProSemiboldIt { return kConfigFontMyriadProSemiboldItKey; }
+(NSString *)FontMyriadProBoldIt { return kConfigFontMyriadProBoldItKey; }
+(NSString *)FontMyriadProSemibold { return kConfigFontMyriadProSemiboldKey; }
+(NSString *)FontMyriadProBold { return kConfigFontMyriadProBoldKey; }
+(NSString *)FontMyriadProBoldCond { return kConfigFontMyriadProBoldCondKey; }
+(NSString *)FontMyriadProRegular { return kConfigFontMyriadProRegularKey; }
+(NSString *)FontMyriadProIt { return kConfigFontMyriadProItKey; }
+(NSString *)FontMyriadProCondIt { return kConfigFontMyriadProCondItKey; }
+(NSString *)FontMyriadProCond { return kConfigFontMyriadProCondKey; }
+(NSString *)FontHelveticaBold { return kConfigFontHelveticaBoldKey; }
+(NSString *)FontHelvetica { return kConfigFontHelveticaKey; }
+(NSString *)FontHelveticaLightOblique { return kConfigFontHelveticaLightObliqueKey; }
+(NSString *)FontHelveticaOblique { return kConfigFontHelveticaObliqueKey; }
+(NSString *)FontHelveticaBoldOblique { return kConfigFontHelveticaBoldObliqueKey; }
+(NSString *)FontHelveticaLight { return kConfigFontHelveticaLightKey; }
+(NSString *)FontRobotoBold { return kConfigFontRobotoBoldKey; }
+(NSString *)FontRobotoRegular { return kConfigFontRobotoRegularKey; }
+(NSString *)FontRobotoMedium { return kConfigFontRobotoMediumKey; }

/**
 @return uicolor for hex color
 */

+(UIColor *)ColorSPAWhiteColor { return UIColorFromRGB(0xFFFFFF); }
+(UIColor *)ColorSPABlackColor { return UIColorFromRGB(0x000000); }
+(UIColor *)ColorSPAGreenColor { return UIColorFromRGB(0x52a63d); }
+(UIColor *)ColorSPAYellowColor { return UIColorFromRGB(0xF2BA27); }

@end
