//
//  SPASignoutSource.m
//  SPA
//
//  Created by Santanu Das Adhikary on 09/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "SPASignoutSource.h"
#import "SPASourceConfig.h"
#import "AFNetworking.h"
#import "CommonReturns.h"
#import "AppDelegate.h"
#import "UserDetails.h"
#import "DataModel.h"
#import "Constant.h"

@implementation SPASignoutSource

+ (SPASignoutSource*)SignoutSource;
{
    static dispatch_once_t onceToken;
    static SPASignoutSource* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[SPASignoutSource alloc]init];
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

-(void)doSignout:(NSArray *)SignoutParam completion:(SPASignoutSourceCompletionBlock)completionBlock
{
    if (completionBlock)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        DataModel *dataModelObj = [DataModel sharedEngine];
        UserDetails *FeatchUserdetails = [dataModelObj fetchCurrentUser];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:FeatchUserdetails.token forHTTPHeaderField:@"X-CSRF-TOKEN"];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@=%@",FeatchUserdetails.session_name,FeatchUserdetails.sessid] forHTTPHeaderField:@"Cookie"];
        
        //NSLog(@"manager.requestSerializer.HTTPRequestHeaders ===> %@",manager.requestSerializer.HTTPRequestHeaders);
        
        [manager POST:[self prepareUrl] parameters:[NSDictionary new] success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSDictionary* infosDictionary = [self dictionaryFromResponseData:operation.responseData jsonPatternFile:@"SPASignoutSource.json"];
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
    return [NSString stringWithFormat:@"%@%@",[SPASourceConfig config].theDbHost,[SPASourceConfig config].Servicelogout];
}

@end
