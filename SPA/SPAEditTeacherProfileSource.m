//
//  SPAEditTeacherProfileSource.m
//  SPA
//
//  Created by Santanu Das Adhikary on 12/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "SPAEditTeacherProfileSource.h"
#import "SPASourceConfig.h"
#import "AFNetworking.h"
#import "CommonReturns.h"
#import "AppDelegate.h"
#import "UserDetails.h"
#import "DataModel.h"
#import "Constant.h"


@implementation SPAEditTeacherProfileSource

#pragma mark -
#pragma mark Init Methods

+ (SPAEditTeacherProfileSource*)editTeacherProfileSource
{
    static dispatch_once_t onceToken;
    static SPAEditTeacherProfileSource* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[SPAEditTeacherProfileSource alloc]init];
    });
    return instance;
}

- (NSDictionary*)dictionaryFromResponseData:(NSData*)responseData jsonPatternFile:(NSString*)jsonFile {
    NSDictionary* dictionary = nil;
    if (responseData ) {
        id object = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        if ([object isKindOfClass:[NSDictionary class]]){
            dictionary = (NSDictionary*)object;
        }
        else
        {
            if (object)
                dictionary = [NSDictionary dictionaryWithObject:object forKey:@"results"];
            else
                dictionary = nil;
        }
    }
    return dictionary;
}

#pragma mark -
#pragma mark Request Methods

-(void)editTeacherProfile:(NSArray *)editProfileParam withImageData:(NSData *)ImageData completion:(SPAEditTeacherProfileCompletionBlock)completionBlock
{
    if (completionBlock)
    {
        NSDictionary* parameters = [[NSDictionary alloc] initWithObjects:editProfileParam forKeys:[[SPASourceConfig config].ParamEditTeacherProfile componentsSeparatedByString:[SPASourceConfig config].SeperatorKey]];
        
        DataModel *dataModelObj = [DataModel sharedEngine];
        UserDetails *FeatchUserdetails = [dataModelObj fetchCurrentUser];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:FeatchUserdetails.token forHTTPHeaderField:@"X-CSRF-TOKEN"];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@=%@",FeatchUserdetails.session_name,FeatchUserdetails.sessid] forHTTPHeaderField:@"Cookie"];

        [manager POST:[self prepareUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSDictionary* infosDictionary = [self dictionaryFromResponseData:operation.responseData jsonPatternFile:@"SPAEditTeacherProfileSourceJsonPattern.json"];
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

- (NSDictionary *)processResponseObject:(NSDictionary*)data
{
    if (data==(NSMutableDictionary *)[NSNull null])
        return nil;
    return removeNull(data);
}
#pragma mark -
#pragma mark Private _Servicelogin_parameters

- (NSString*)prepareUrl
{
    return [NSString stringWithFormat:@"%@%@",[SPASourceConfig config].theDbHost,[SPASourceConfig config].ServiceEditTeacherProfile];
}

@end
