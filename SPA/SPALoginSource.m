//
//  SPALoginSource.m
//  SPA
//
//  Created by Santanu Das Adhikary on 05/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "SPALoginSource.h"
#import "SPASourceConfig.h"
#import "AFNetworking.h"
#import "CommonReturns.h"

@implementation SPALoginSource

#pragma mark -
#pragma mark Init Methods

+ (SPALoginSource*)loginDetailsSource;
{
    static dispatch_once_t onceToken;
    static SPALoginSource* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[SPALoginSource alloc]init];
    });
    return instance;
}

#pragma mark -
#pragma mark Request Methods

-(void)getLoginDetails:(NSArray *)LoginParam completion:(SPALoginCompletionBlock)completionBlock;
{
    if (completionBlock)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        NSDictionary* parameters = [[NSDictionary alloc] initWithObjects:LoginParam forKeys:[[SPASourceConfig config].Paramlogin_parameters componentsSeparatedByString:[SPASourceConfig config].SeperatorKey]];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        [manager POST:[self prepareUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSDictionary* infosDictionary = [self dictionaryFromResponseData:operation.responseData jsonPatternFile:@"SPALoginSourceJsonPattern.json"];
             dispatch_async(dispatch_get_main_queue(), ^{
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                 
                 completionBlock([self processResponseObject:infosDictionary], nil);
             });
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                 
                 NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                 if ([ErrorResponse length] == 0)
                     ErrorResponse = nil;
                 completionBlock(nil, ErrorResponse);
             });
         }];
    }
}

#pragma mark -
#pragma mark Data Parsing

- (NSDictionary*)processResponseObject:(NSDictionary*)data
{
    if (data == nil)
        return nil;
    return (removeNull(data));
}

#pragma mark -
#pragma mark Private _Servicelogin_parameters

- (NSString*)prepareUrl
{
    return [NSString stringWithFormat:@"%@%@",[SPASourceConfig config].theDbHost,[SPASourceConfig config].Servicelogin_parameters];
}

@end
