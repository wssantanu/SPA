//
//  SPAStringConfig.m
//  SPA
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "SPAStringConfig.h"
#import "KM_NSDictionary+SafeValues.h"

#define kConfigAppNameKey @"Application_Name"

@implementation SPAStringConfig

#pragma mark -
#pragma mark Init Methods

+ (SPAStringConfig*)config{
    static dispatch_once_t onceToken;
    static SPAStringConfig* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[SPAStringConfig alloc] init];
    });
    return instance;
}

- (id) init{
    self = [super init];
    if (self){
        NSBundle* bundle = [NSBundle bundleForClass:[self class]];
        NSDictionary* config = [[NSDictionary alloc]initWithContentsOfFile:[bundle pathForResource:@"StringConfig" ofType:@"plist"]];
        _Application_Name = NSLocalizedString([config km_safeStringForKey:kConfigAppNameKey],@"_Application_Name");
    }
    return self;
}


@end
