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
#import "AppDelegate.h"
#import "UserDetails.h"
#import "DataModel.h"
#import "Constant.h"

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
    if (data==(NSMutableDictionary *)[NSNull null])
        return nil;
        
        NSString *sessid            = [data objectForKey:@"sessid"];
        NSString *session_name      = [data objectForKey:@"session_name"];
        NSString *token             = [data objectForKey:@"token"];
        
        NSDictionary *userDictionary = [data objectForKey:@"user"];
        
        NSString *access            = removeNull([userDictionary objectForKey:@"access"]);
        NSString *created           = [userDictionary objectForKey:@"created"];
        NSString *field_user_full_name          = [self getValueFromDictionary:[userDictionary objectForKey:@"field_user_full_name"]];
        NSString *field_user_keep_logged_in     = [self getValueFromDictionary:[userDictionary objectForKey:@"field_user_keep_logged_in"]];
        NSString *field_user_office_hours       = [self getValueFromDictionary:[userDictionary objectForKey:@"field_user_office_hours"]];
        NSString *field_user_office_location    = [self getValueFromDictionary:[userDictionary objectForKey:@"field_user_office_location"]];
        NSString *field_user_phone              = [self getValueFromDictionary:[userDictionary objectForKey:@"field_user_phone"]];
        NSString *field_user_receive_emails     = [self getValueFromDictionary:[userDictionary objectForKey:@"field_user_receive_emails"]];
        NSString *field_user_school             = [self getValueFromDictionary:[userDictionary objectForKey:@"field_user_school"]];
        NSString *language          = [userDictionary objectForKey:@"language"];
        NSString *login             = removeNull([NSString stringWithFormat:@"%@",[userDictionary objectForKey:@"login"]]);
        NSString *mail              = [userDictionary objectForKey:@"mail"];
        NSString *name              = [userDictionary objectForKey:@"name"];
        NSString *signature         = [userDictionary objectForKey:@"signature"];
        NSString *signature_format  = [userDictionary objectForKey:@"signature_format"];
        NSString *status            = [userDictionary objectForKey:@"status"];
        NSString *theme             = [userDictionary objectForKey:@"theme"];
        NSString *timezone          = removeNull([userDictionary objectForKey:@"timezone"]);
        NSString *uid               = [userDictionary objectForKey:@"uid"];
        NSString *picture           = ([[userDictionary objectForKey:@"picture"] isKindOfClass:[NSDictionary class]])?[self getPictureFromDictionary:[userDictionary objectForKey:@"picture"]]:@"";
        NSString *userrole          = [[self getUserRoleFromDictionary:[userDictionary objectForKey:@"roles"]] isEqualToString:@"teacher"]?@"4":@"5";

    DataModel *dataModelObj = [DataModel sharedEngine];
    [dataModelObj deleteAllObjectsForEntity:Constant.EntityForUser];
    
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UserDetails *UserDetailsObj             = (UserDetails *)[dataModelObj objectOfType:Constant.EntityForUser forKey:@"uid" andValue:uid withCondition:nil newFlag:YES forManagedObjectContext:mainDelegate.managedObjectContext];
    UserDetailsObj.sessid                   = sessid;
    UserDetailsObj.session_name             = session_name;
    UserDetailsObj.token                    = token;
    UserDetailsObj.access                   = access;
    UserDetailsObj.created                  = created;
    UserDetailsObj.user_full_name           = field_user_full_name;
    UserDetailsObj.keep_logged_in           = field_user_keep_logged_in;
    UserDetailsObj.user_office_hours        = field_user_office_hours;
    UserDetailsObj.user_office_location     = field_user_office_location;
    UserDetailsObj.user_phone               = field_user_phone;
    UserDetailsObj.user_receive_emails      = field_user_receive_emails;
    UserDetailsObj.user_school              = field_user_school;
    UserDetailsObj.language                 = language;
    UserDetailsObj.mail                     = mail;
    UserDetailsObj.name                     = name;
    UserDetailsObj.signature                = signature;
    UserDetailsObj.signature_format         = signature_format;
    UserDetailsObj.status                   = status;
    UserDetailsObj.theme                    = theme;
    UserDetailsObj.timezone                 = timezone;
    UserDetailsObj.uid                      = uid;
    UserDetailsObj.picture                  = picture;
    UserDetailsObj.roles                    = userrole;
    UserDetailsObj.login                    = login;
    
    [mainDelegate saveContext];
    
    NSUserDefaults *Prefs = [NSUserDefaults standardUserDefaults];
    [Prefs setObject:uid forKey:@"logedin_userid"];
    
    [Prefs synchronize];
    
    return (removeNull(data));
}

-(NSString *)getValueFromDictionary :(NSDictionary *)DataDictionary
{
    NSLog(@"DataDictionary ==>%@",DataDictionary);
    
    NSString *ReturnValue = @"";
    NSArray *Dic = [DataDictionary objectForKey:@"und"];
    if(Dic!=NULL)
        ReturnValue = [[Dic objectAtIndex:0] objectForKey:@"value"];
    return ReturnValue;
}

-(NSString *)getPictureFromDictionary :(NSDictionary *)DataDictionary
{
    if ([DataDictionary count]>0) {
        return (removeNull([DataDictionary objectForKey:@"url"])!=nil)?removeNull([DataDictionary objectForKey:@"url"]):@"";
    } else {
        return @"";
    }
    return @"";
}

-(NSString *)getUserRoleFromDictionary :(NSDictionary *)DataDictionary
{
    NSLog(@"role dictionary ====> %@",DataDictionary);
    
    NSMutableArray *_myArray = [[NSMutableArray alloc] init];
    for (id item in DataDictionary) {
        [_myArray addObject:[DataDictionary objectForKey:item]];
    }
    NSLog(@"role _myArray ====> %@",_myArray);
    
    return [_myArray objectAtIndex:1];
}

#pragma mark -
#pragma mark Private _Servicelogin_parameters

- (NSString*)prepareUrl
{
    return [NSString stringWithFormat:@"%@%@",[SPASourceConfig config].theDbHost,[SPASourceConfig config].Servicelogin_parameters];
}

@end
