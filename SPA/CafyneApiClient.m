//
//  CafyneApiClient.m
//  Cafyne
//
//  Created by Ashish Kumar on 02/12/14.
//  Copyright (c) 2014 Cafyne. All rights reserved.
//

#import "CafyneApiClient.h"

//Basic Auth Base url
static NSString * const APIBaseURLString =@"http://studentplanner.test.webspiders.com/user.api/";

@implementation CafyneApiClient

//Setting the base url
+ (instancetype)sharedClient
{
    static CafyneApiClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CafyneApiClient alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURLString]];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.requestSerializer.timeoutInterval = 60.0;
        _sharedClient.requestSerializer.HTTPShouldHandleCookies=YES;
        _sharedClient.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
        
        // [_sharedClient.requestSerializer setTimeoutInterval:30];
        
    });
    
    return _sharedClient;
}

+ (instancetype)sharedBasicLoginClient
{
    static CafyneApiClient *_sharedBasicClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedBasicClient = [[CafyneApiClient alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURLString]];
        _sharedBasicClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedBasicClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedBasicClient.requestSerializer.HTTPShouldHandleCookies=YES;
        _sharedBasicClient.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
        [_sharedBasicClient.requestSerializer setTimeoutInterval:30];
        
    });

    return _sharedBasicClient;
}



@end

