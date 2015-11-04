//
//  SPAColorConfig.m
//  SPA
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "SPAColorConfig.h"
#import "KM_NSDictionary+SafeValues.h"

/**
 * @key define for MyriadPro font
 **/

#define kConfigFontSPAWhiteKey @"SPAWhiteColor"
#define kConfigFontSPABlackKey @"SPABlackwColor"
#define kConfigFontSPAGreenKey @"SPAGreenColor"
#define kConfigFontSPAYellowKey @"SPAYellowColor"

@implementation SPAColorConfig

+ (SPAColorConfig*)config{
    static dispatch_once_t onceToken;
    static SPAColorConfig* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[SPAColorConfig alloc] init];
    });
    return instance;
}

- (id) init{
    
    self = [super init];
    if (self){
        
        NSBundle* bundle = [NSBundle bundleForClass:[self class]];
        NSDictionary* Baseconfig = [[NSDictionary alloc]initWithContentsOfFile:[bundle pathForResource:@"ColorConfig" ofType:@"plist"]];
        
        _SPAWhite               = [Baseconfig km_safeStringForKey:kConfigFontSPAWhiteKey];
        _SPABlack               = [Baseconfig km_safeStringForKey:kConfigFontSPABlackKey];
        _SPAGreen               = [Baseconfig km_safeStringForKey:kConfigFontSPAGreenKey];
        _SPAYellow              = [Baseconfig km_safeStringForKey:kConfigFontSPAYellowKey];
    }
    return self;
}

@end
