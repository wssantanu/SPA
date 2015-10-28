//
//  KMSourceConfig.m
//  TheMovieDB
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "SPASourceConfig.h"
#import "KM_NSDictionary+SafeValues.h"
#import "Constant.h"

@implementation SPASourceConfig

#pragma mark -
#pragma mark Init Methods

+ (SPASourceConfig*)config{
    static dispatch_once_t onceToken;
    static SPASourceConfig* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[SPASourceConfig alloc] init];
    });
    return instance;
}

- (id) init{
    
    self = [super init];
    if (self){
        NSBundle* bundle = [NSBundle bundleForClass:[self class]];
        
        NSDictionary* Baseconfig = [[NSDictionary alloc]initWithContentsOfFile:[bundle pathForResource:@"SourceConfig" ofType:@"plist"]];
        _theDbHost = [Baseconfig km_safeStringForKey:kConfigTheMovieDbHostKey];
        _version = [Baseconfig km_safeStringForKey:kConfigVersionKey];
        _build = [Baseconfig km_safeStringForKey:kConfigBuildKey];
        _apiKey = [Baseconfig km_safeStringForKey:kConfigApiKey];
        
        NSDictionary* Paramconfig = [[NSDictionary alloc]initWithContentsOfFile:[bundle pathForResource:@"ParametersConfig" ofType:@"plist"]];
        _LoginParam = [Paramconfig km_safeStringForKey:kConfigLoginKey];
    }
    return self;
}

@end
