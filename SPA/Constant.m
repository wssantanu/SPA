//
//  Constant.m
//  SPA
//
//  Created by Santanu Das Adhikary on 16/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "Constant.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <CommonCrypto/CommonHMAC.h>
#import <objc/runtime.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <ifaddrs.h>

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

/**
 @key define for Entity
 */

#define kConfigUserEntityKey @"UserDetails"

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
+(ShowProfileViewController *)ShowProfileViewController {
    return [[ShowProfileViewController alloc] initWithNibName:NSStringFromClass([ShowProfileViewController class]) bundle:[NSBundle mainBundle]];
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

+(NSString *)EntityForUser { return kConfigUserEntityKey; }

/**
 @return service setails
 @Url details
 **/

static NSNumber *_ScreenOfPlatform4m;

+ (CGSize) ScreenBoundsForPlatform4m {
    
    return CGSizeMake(320, 480);
}

+ (BOOL) ScreenOfPlatform4m {
    
    return YES;
}

+ (BOOL) ScreenOfPlatform5e {
    
    return YES;
}

+ (BOOL) DeviceIsIphoneFive {
    
    return ([[UIScreen mainScreen] bounds].size.height > 500.0f)?YES:NO;
    
}

+ (BOOL) IsConnectedToInternet {
    
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)&zeroAddress);
    
    if (reachability) {
        SCNetworkReachabilityFlags flags;
        BOOL worked = SCNetworkReachabilityGetFlags(reachability, &flags);
        CFRelease(reachability);
        
        if (worked) {
            
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0) {
                return NO;
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0) {
                return YES;
            }
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand) != 0) || (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0)) {
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0) {
                    return YES;
                }
            }
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN) {
                return YES;
            }
        }
        
    }
    return NO;
}

+(NSString*) LastExecutedMethod {
    
    return [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__];
}

+(BOOL) ShowLastExecutedMethod {
    
    return (DEBUGMODE)?YES:NO;
}

-(BOOL)ValidateTextField:(NSString *)TextFieldValue {
    return YES;
}

+(NSString *)CleanTextField:(NSString *)TextfieldName
{
    NSString *Cleanvalue = [TextfieldName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return Cleanvalue;
}

+(BOOL)ValidateEmail:(NSString *)EmailValue
{
    IMFAPPPRINTMETHOD();
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    NSString* CleanEmailValue = [Constant CleanTextField:EmailValue];
    return [emailTest evaluateWithObject:CleanEmailValue];
}

-(BOOL)ValidateSpecialCharacter:(NSString *)DataValue
{
    IMFAPPPRINTMETHOD();
    
    NSCharacterSet *ALLOWEDCHARATERSET =[[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    NSString *Cleanvalue = [Constant CleanTextField:DataValue];
    if ([Cleanvalue rangeOfCharacterFromSet:ALLOWEDCHARATERSET].location != NSNotFound)
        return NO;
    else
        return YES;
}

-(NSDictionary *)executeFetch:(NSString *)query
{
    IMFAPPPRINTMETHOD();
    
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    return results;
}

-(NSDictionary *)GenerateParamValueForSubmit:(NSArray *)ParamArray FieldArray:(NSArray *)FieldArray {
    
    IMFAPPPRINTMETHOD();
    
    @try {
        
        NSMutableDictionary *ParamDictionary = [[NSMutableDictionary alloc] initWithCapacity:(NSUInteger)FieldArray.count];
        if ((NSUInteger)ParamArray.count > 0) {
            if((NSUInteger)FieldArray.count >0) {
                for (int i = 0; i<(NSUInteger)ParamArray.count; i++) {
                    [ParamDictionary setObject:[FieldArray objectAtIndex:i] forKey:[ParamArray objectAtIndex:i]];
                }
            } else {
                NSLog(@"Field data is blank");
            }
        } else {
            NSLog(@"Param object is blank");
        }
        return ParamDictionary;
    }
    @catch (NSException *Exception) {
        NSLog(@"Err in ParamDictionary %@",Exception);
    }
}

-(NSString *)CallURLForServerReturn: (NSMutableDictionary *)TotalData URL:(NSString *)UrlType
{
    
    IMFAPPPRINTMETHOD();
    
    NSMutableString *URLstring = [[NSMutableString alloc]init];
    
    int i=0;
    for (id key in TotalData) {
        
        i++;
        id anObject = [TotalData objectForKey:key];
        if(i==TotalData.count)
            [URLstring appendString:[NSString stringWithFormat:@"%@=%@",key,[[Constant CleanTextField:anObject] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        else
            [URLstring appendString:[NSString stringWithFormat:@"%@=%@&",key,[[Constant CleanTextField:anObject] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
    NSString *FinalString = @"";
    return FinalString;
    
}

-(BOOL)validatePhone:(NSString*)phone {
    
    IMFAPPPRINTMETHOD();
    
    if ([phone length] < 10) {
        return NO;
    }
    NSString *phoneRegex = @"^[0-9]{3}-[0-9]{3}-[0-9]{4}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return ![test evaluateWithObject:phone];
}
- (NSString *) stripTags:(NSString *)s
{
    
    IMFAPPPRINTMETHOD();
    
    NSRange r;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

@end
