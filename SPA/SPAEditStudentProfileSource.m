//
//  SPAEditStudentProfileSource.m
//  SPA
//
//  Created by Santanu Das Adhikary on 12/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "SPAEditStudentProfileSource.h"
#import "SPASourceConfig.h"
#import "AFNetworking.h"
#import "CommonReturns.h"
#import "AppDelegate.h"
#import "UserDetails.h"
#import "DataModel.h"
#import "Constant.h"


@implementation SPAEditStudentProfileSource

#pragma mark -
#pragma mark Init Methods

+ (SPAEditStudentProfileSource*)editStudentProfileSource
{
    static dispatch_once_t onceToken;
    static SPAEditStudentProfileSource* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[SPAEditStudentProfileSource alloc]init];
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

-(void)editStudentProfile:(NSArray *)editProfileParam withImageData:(NSData *)ImageData completion:(SPAEditStudentProfileCompletionBlock)completionBlock
{
    if (completionBlock)
    {
        NSDictionary* parameters = [[NSDictionary alloc] initWithObjects:editProfileParam forKeys:[[SPASourceConfig config].ParamEditStudentProfile componentsSeparatedByString:[SPASourceConfig config].SeperatorKey]];
        
        DataModel *dataModelObj = [DataModel sharedEngine];
        UserDetails *FeatchUserdetails = [dataModelObj fetchCurrentUser];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:FeatchUserdetails.token forHTTPHeaderField:@"X-CSRF-TOKEN"];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@=%@",FeatchUserdetails.session_name,FeatchUserdetails.sessid] forHTTPHeaderField:@"Cookie"];
        
        [manager POST:[self prepareUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSDictionary* infosDictionary = [self dictionaryFromResponseData:operation.responseData jsonPatternFile:@"SPAEditStudentProfileSourceJsonPattern.json"];
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
    return [NSString stringWithFormat:@"%@%@",[SPASourceConfig config].theDbHost,[SPASourceConfig config].ServiceEditStudentProfile];
}

@end
