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
    return [[ViewController alloc] initWithNibName:NSStringFromClass([ViewController class]) bundle:[NSBundle mainBundle]];
}
+(LoginViewController *)LoginViewController {
    return [[LoginViewController alloc] initWithNibName:NSStringFromClass([LoginViewController class]) bundle:[NSBundle mainBundle]];
}
+(SignupController *)SignupController {
    return [[SignupController alloc] initWithNibName:NSStringFromClass([SignupController class]) bundle:[NSBundle mainBundle]];
}
+(ForgetPasswordControllerViewController *)ForgetPasswordControllerViewController {
    return [[ForgetPasswordControllerViewController alloc] initWithNibName:NSStringFromClass([ForgetPasswordControllerViewController class]) bundle:[NSBundle mainBundle]];
}
+(EditProfileViewController *)EditProfileViewController {
    return [[EditProfileViewController alloc] initWithNibName:NSStringFromClass([EditProfileViewController class]) bundle:[NSBundle mainBundle]];
}
+(ClassListViewController *)ClassListViewController {
    return [[ClassListViewController alloc] initWithNibName:NSStringFromClass([ClassListViewController class]) bundle:[NSBundle mainBundle]];
}
+(AddClassViewController *)AddClassViewController {
    return [[AddClassViewController alloc] initWithNibName:NSStringFromClass([AddClassViewController class]) bundle:[NSBundle mainBundle]];
}
+(ScheduleViewController *)ScheduleViewController {
    return [[ScheduleViewController alloc] initWithNibName:NSStringFromClass([ScheduleViewController class]) bundle:[NSBundle mainBundle]];
}
+(AddScheduleViewController *)AddScheduleViewController {
    return [[AddScheduleViewController alloc] initWithNibName:NSStringFromClass([AddScheduleViewController class]) bundle:[NSBundle mainBundle]];
}
+(TaskListViewController *)TaskListViewController {
    return [[TaskListViewController alloc] initWithNibName:NSStringFromClass([TaskListViewController class]) bundle:[NSBundle mainBundle]];
}
+(AddTaskViewController *)AddTaskViewController {
    return [[AddTaskViewController alloc] initWithNibName:NSStringFromClass([AddTaskViewController class]) bundle:[NSBundle mainBundle]];
}
+(AgendaListDayViewController *)AgendaListDayViewController {
    return [[AgendaListDayViewController alloc] initWithNibName:NSStringFromClass([AgendaListDayViewController class]) bundle:[NSBundle mainBundle]];
}
+(AgendaListFiveDayViewController *)AgendaListFiveDayViewController {
    return [[AgendaListFiveDayViewController alloc] initWithNibName:NSStringFromClass([AgendaListFiveDayViewController class]) bundle:[NSBundle mainBundle]];
}
+(AgendaListMonthViewController *)AgendaListMonthViewController {
    return [[AgendaListMonthViewController alloc] initWithNibName:NSStringFromClass([AgendaListMonthViewController class]) bundle:[NSBundle mainBundle]];
}
+(ClassTasksViewController *)ClassTasksViewController{
    return [[ClassTasksViewController alloc] initWithNibName:NSStringFromClass([ClassTasksViewController class]) bundle:[NSBundle mainBundle]];
}
+(MaterialsListViewController *)MaterialsListViewController {
    return [[MaterialsListViewController alloc] initWithNibName:NSStringFromClass([MaterialsListViewController class]) bundle:[NSBundle mainBundle]];
}
+(StudentsViewController *)StudentsViewController {
    return [[StudentsViewController alloc] initWithNibName:NSStringFromClass([StudentsViewController class]) bundle:[NSBundle mainBundle]];
}
+(AlertStudentsViewController *)AlertStudentsViewController {
    return [[AlertStudentsViewController alloc] initWithNibName:NSStringFromClass([AlertStudentsViewController class]) bundle:[NSBundle mainBundle]];
}
+(ClassInfoViewController *)ClassInfoViewController {
    return [[ClassInfoViewController alloc] initWithNibName:NSStringFromClass([ClassInfoViewController class]) bundle:[NSBundle mainBundle]];
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

/**
 @return service setails
 @parm details
 **/



/**
 @return service setails
 @Url details
 **/


@end
