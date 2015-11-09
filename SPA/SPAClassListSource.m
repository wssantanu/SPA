//
//  SPAClassListSource.m
//  SPA
//
//  Created by Santanu Das Adhikary on 09/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "SPAClassListSource.h"
#import "SPASourceConfig.h"
#import "AFNetworking.h"
#import "CommonReturns.h"
#import "AppDelegate.h"
#import "UserDetails.h"
#import "DataModel.h"
#import "Constant.h"
#import "ClassDetails.h"
#import "ClassSlots.h"

@implementation SPAClassListSource

+ (SPAClassListSource*)SPAClassListSource
{
    static dispatch_once_t onceToken;
    static SPAClassListSource* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[SPAClassListSource alloc]init];
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

-(void)getClasslist:(NSArray *)ClassListParam completion:(SPAClassListSourceCompletionBlock)completionBlock
{
    if (completionBlock)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        DataModel *dataModelObj = [DataModel sharedEngine];
        UserDetails *FeatchUserdetails = [dataModelObj fetchCurrentUser];
        
        NSDictionary* parameters = [[NSDictionary alloc] initWithObjects:ClassListParam forKeys:[[SPASourceConfig config].ParamMyClassList componentsSeparatedByString:[SPASourceConfig config].SeperatorKey]];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:FeatchUserdetails.token forHTTPHeaderField:@"X-CSRF-TOKEN"];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@=%@",FeatchUserdetails.session_name,FeatchUserdetails.sessid] forHTTPHeaderField:@"Cookie"];
        
        [manager POST:[self prepareUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSDictionary* infosDictionary = [self dictionaryFromResponseData:operation.responseData jsonPatternFile:@"SPAClassListSource.json"];
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
    
    DataModel *dataModelObj = [DataModel sharedEngine];
    [dataModelObj deleteAllObjectsForEntity:Constant.EntityForClassSlots];
    
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //if ([[data objectForKey:@"error"] intValue] !=0) {
        for (id DataObject in [data objectForKey:@"classes"]) {
            
            NSString *field_color_code              = [DataObject objectForKey:@"field_color_code"];
            NSString *field_end_date                = [DataObject objectForKey:@"field_end_date"];
            NSString *field_location                = [DataObject objectForKey:@"field_location"];
            NSString *field_section                 = [DataObject objectForKey:@"field_section"];
            NSString *field_semester                = [DataObject objectForKey:@"field_semester"];
            NSString *field_start_date              = [DataObject objectForKey:@"field_start_date"];
            NSString *classid                       = [DataObject objectForKey:@"id"];
            NSString *classname                     = [DataObject objectForKey:@"name"];
            NSString *teacherFullname               = [DataObject objectForKey:@"teacherFullname"];
            NSString *teacheremail                  = [DataObject objectForKey:@"teacheremail"];
            NSString *teacherofficeLocation         = [DataObject objectForKey:@"teacherofficeLocation"];
            NSString *teacherofficehours            = [DataObject objectForKey:@"teacherofficehours"];
            NSString *techerphoneno                 = [DataObject objectForKey:@"techerphoneno"];
            
            ClassDetails *ClassDetailsObj            = (ClassDetails *)[dataModelObj objectOfType:Constant.EntityForClassDetails forKey:@"classId" andValue:classid withCondition:nil newFlag:YES forManagedObjectContext:mainDelegate.managedObjectContext];
            
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            f.numberStyle = kCFNumberFormatterNoStyle;
            NSNumber *classidCov = [f numberFromString:classid];
            
            ClassDetailsObj.field_color_code         = (NSString *)field_color_code;
            ClassDetailsObj.field_end_date           = (NSString *)field_end_date;
            ClassDetailsObj.field_location           = (NSString *)field_location;
            ClassDetailsObj.field_section            = (NSString *)field_section;
            ClassDetailsObj.field_semester           = (NSString *)field_semester;
            ClassDetailsObj.field_start_date         = (NSString *)field_start_date;
            ClassDetailsObj.classId                  = classidCov;
            ClassDetailsObj.name                     = (NSString *)classname;
            ClassDetailsObj.teacherFullname          = (NSString *)teacherFullname;
            ClassDetailsObj.teacheremail             = (NSString *)teacheremail;
            ClassDetailsObj.teacherofficeLocation    = (NSString *)teacherofficeLocation;
            ClassDetailsObj.teacherofficehours       = (NSString *)teacherofficehours;
            ClassDetailsObj.techerphoneno            = (NSString *)techerphoneno;
            
            [mainDelegate saveContext];
            
            for (id slotsDetailsObject in [DataObject objectForKey:@"slots"]) {
                
                NSString *KeyVal = nil;
                for( NSString *aKey in [slotsDetailsObject allKeys] ) { KeyVal = aKey; }
                
                for (id dataObject in [slotsDetailsObject objectForKey:KeyVal]) {
                    
                    ClassSlots *ClassSlotObject = (ClassSlots *)[NSEntityDescription insertNewObjectForEntityForName:@"ClassSlots" inManagedObjectContext:mainDelegate.managedObjectContext];
                    
                    ClassSlotObject.classId             = classidCov;
                    ClassSlotObject.end_time            = [dataObject objectForKey:@"end_time"];
                    ClassSlotObject.start_time          = [dataObject objectForKey:@"start_time"];
                    ClassSlotObject.dayId               = [self ConvertKeyToDateVal:KeyVal];
                    
                    [mainDelegate saveContext];
                    
                }
            }
        }
    
    return removeNull(data);
}

-(NSString *)ConvertKeyToDateVal :(NSString *)KeyVal
{
    NSArray *DaysArray = @[@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat"];
    NSUInteger indexOfTheObject;
    
    if ([DaysArray containsObject:KeyVal]) {
        indexOfTheObject = [DaysArray indexOfObject:KeyVal];
    }
    return [NSString stringWithFormat:@"%lu",(unsigned long)indexOfTheObject];
}

#pragma mark -
#pragma mark Private _Servicelogin_parameters

- (NSString*)prepareUrl
{
    return [NSString stringWithFormat:@"%@%@",[SPASourceConfig config].theDbHost,[SPASourceConfig config].ServiceMyClassList];
}

@end
