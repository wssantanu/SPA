//
//  SPAFontConfig.m
//  SPA
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "SPAFontConfig.h"
#import "KM_NSDictionary+SafeValues.h"

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

@implementation SPAFontConfig

+ (SPAFontConfig*)config{
    static dispatch_once_t onceToken;
    static SPAFontConfig* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[SPAFontConfig alloc] init];
    });
    return instance;
}

- (id) init{
    
    self = [super init];
    if (self){
        
        NSBundle* bundle = [NSBundle bundleForClass:[self class]];
        NSDictionary* Baseconfig = [[NSDictionary alloc]initWithContentsOfFile:[bundle pathForResource:@"FontConfig" ofType:@"plist"]];
        
        _MyriadProCond          = [Baseconfig km_safeStringForKey:kConfigFontMyriadProCondKey];
        _MyriadProCondIt        = [Baseconfig km_safeStringForKey:kConfigFontMyriadProCondItKey];
        _MyriadProIt            = [Baseconfig km_safeStringForKey:kConfigFontMyriadProItKey];
        _MyriadProBoldCondIt    = [Baseconfig km_safeStringForKey:kConfigFontMyriadProBoldCondItKey];
        _MyriadProRegular       = [Baseconfig km_safeStringForKey:kConfigFontMyriadProRegularKey];
        _MyriadProBoldCond      = [Baseconfig km_safeStringForKey:kConfigFontMyriadProBoldCondKey];
        _MyriadProBold          = [Baseconfig km_safeStringForKey:kConfigFontMyriadProBoldKey];
        _MyriadProSemibold      = [Baseconfig km_safeStringForKey:kConfigFontMyriadProSemiboldKey];
        _MyriadProBoldIt        = [Baseconfig km_safeStringForKey:kConfigFontMyriadProBoldItKey];
        _MyriadProSemiboldIt    = [Baseconfig km_safeStringForKey:kConfigFontMyriadProSemiboldItKey];
        
        _HelveticaBold          = [Baseconfig km_safeStringForKey:kConfigFontHelveticaBoldKey];
        _Helvetica              = [Baseconfig km_safeStringForKey:kConfigFontHelveticaKey];
        _HelveticaLightOblique  = [Baseconfig km_safeStringForKey:kConfigFontHelveticaLightObliqueKey];
        _HelveticaOblique       = [Baseconfig km_safeStringForKey:kConfigFontHelveticaObliqueKey];
        _HelveticaBoldOblique   = [Baseconfig km_safeStringForKey:kConfigFontHelveticaBoldObliqueKey];
        _HelveticaLight         = [Baseconfig km_safeStringForKey:kConfigFontHelveticaLightKey];
        
        _RobotoBold             = [Baseconfig km_safeStringForKey:kConfigFontRobotoBoldKey];
        _RobotoRegular          = [Baseconfig km_safeStringForKey:kConfigFontRobotoRegularKey];
        _RobotoMedium           = [Baseconfig km_safeStringForKey:kConfigFontRobotoMediumKey];
        
    }
    return self;
}

@end
