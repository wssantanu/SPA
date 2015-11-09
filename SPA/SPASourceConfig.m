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

/**
 * SPASourceConfig const
 */

#define kConfigVersionKey @"version"
#define kConfigBuildKey @"build"
#define kConfigTheMovieDbHostKey @"thedb_host"
#define kConfigApiKey @"api_key"
#define kConfigParamSeperatorKey @"seperator_key"

#define kConfigLoginKey @"login_parameters"
#define kConfigrequest_newpasswordKey @"request_newpassword"
#define kConfiglogoutnKey @"logout"
#define kConfigUser_RegistrationKey @"User_Registration"
#define kConfigClass_CreatenKey @"Class_Create"
#define kConfigClass_EditKey @"Class_Edit"
#define kConfigFetch_Class_listKey @"Fetch_Class_list"
#define kConfigEvent_CreateKey @"Event_Create"
#define kConfigEvent_EditKey @"Event_Edit"
#define kConfigTask_CreateKey @"Task_Create"
#define kConfigTask_Status_ChangeKey @"Task_Status_Change"
#define kConfigTask_DeleteKey @"Task_Delete"
#define kConfigFetch_class_TasklistKey @"Fetch_class_Tasklist"
#define kConfigUpload_MaterialKey @"Upload_Material"
#define kConfigMaterial_DeleteKey @"Material_Delete"
#define kConfigMaterial_of_classKey @"Material_of_class"
#define kConfigchange_user_passwordKey @"change_user_password"
#define kConfigMyClassListKey @"my_class_list"


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

- (id) init {
    
    self = [super init];
    if (self){
        
        NSBundle* bundle = [NSBundle bundleForClass:[self class]];
        
        NSDictionary* Baseconfig          = [[NSDictionary alloc]initWithContentsOfFile:[bundle pathForResource:@"SourceConfig" ofType:@"plist"]];
        NSDictionary* Paramconfig         = [[NSDictionary alloc]initWithContentsOfFile:[bundle pathForResource:@"ParametersConfig" ofType:@"plist"]];
        NSDictionary* Serviceconfig       = [[NSDictionary alloc]initWithContentsOfFile:[bundle pathForResource:@"ServiceConfig" ofType:@"plist"]];
        
        _theDbHost                        = [Baseconfig km_safeStringForKey:kConfigTheMovieDbHostKey];
        _version                          = [Baseconfig km_safeStringForKey:kConfigVersionKey];
        _build                            = [Baseconfig km_safeStringForKey:kConfigBuildKey];
        _apiKey                           = [Baseconfig km_safeStringForKey:kConfigApiKey];
        _SeperatorKey                     = [Baseconfig km_safeStringForKey:kConfigParamSeperatorKey];
        
        _Paramlogin_parameters            = [Paramconfig km_safeStringForKey:kConfigLoginKey];
        _Paramrequest_newpassword         = [Paramconfig km_safeStringForKey:kConfigrequest_newpasswordKey];
        _Paramlogout                      = [Paramconfig km_safeStringForKey:kConfiglogoutnKey];
        _ParamUser_Registration           = [Paramconfig km_safeStringForKey:kConfigUser_RegistrationKey];
        _ParamClass_Create                = [Paramconfig km_safeStringForKey:kConfigClass_CreatenKey];
        _ParamClass_Edit                  = [Paramconfig km_safeStringForKey:kConfigClass_EditKey];
        _ParamFetch_Class_list            = [Paramconfig km_safeStringForKey:kConfigFetch_Class_listKey];
        _ParamEvent_Create                = [Paramconfig km_safeStringForKey:kConfigEvent_CreateKey];
        _ParamEvent_Edit                  = [Paramconfig km_safeStringForKey:kConfigEvent_EditKey];
        _ParamTask_Create                 = [Paramconfig km_safeStringForKey:kConfigTask_CreateKey];
        _ParamTask_Status_Change          = [Paramconfig km_safeStringForKey:kConfigTask_Status_ChangeKey];
        _ParamTask_Delete                 = [Paramconfig km_safeStringForKey:kConfigTask_DeleteKey];
        _ParamFetch_class_Tasklist        = [Paramconfig km_safeStringForKey:kConfigFetch_class_TasklistKey];
        _ParamUpload_Material             = [Paramconfig km_safeStringForKey:kConfigUpload_MaterialKey];
        _ParamMaterial_Delete             = [Paramconfig km_safeStringForKey:kConfigMaterial_DeleteKey];
        _ParamMaterial_of_class           = [Paramconfig km_safeStringForKey:kConfigMaterial_of_classKey];
        _ParamMaterial_of_class           = [Paramconfig km_safeStringForKey:kConfigchange_user_passwordKey];
        _Paramchange_user_password        = [Paramconfig km_safeStringForKey:kConfigchange_user_passwordKey];
        _ParamMyClassList                 = [Paramconfig km_safeStringForKey:kConfigMyClassListKey];
        
        _Servicelogin_parameters          = [Serviceconfig km_safeStringForKey:kConfigLoginKey];
        _Servicerequest_newpassword       = [Serviceconfig km_safeStringForKey:kConfigrequest_newpasswordKey];
        _Servicelogout                    = [Serviceconfig km_safeStringForKey:kConfiglogoutnKey];
        _ServiceUser_Registration         = [Serviceconfig km_safeStringForKey:kConfigUser_RegistrationKey];
        _ServiceClass_Create              = [Serviceconfig km_safeStringForKey:kConfigClass_CreatenKey];
        _ServiceClass_Edit                = [Serviceconfig km_safeStringForKey:kConfigClass_EditKey];
        _ServiceFetch_Class_list          = [Serviceconfig km_safeStringForKey:kConfigFetch_Class_listKey];
        _ServiceEvent_Create              = [Serviceconfig km_safeStringForKey:kConfigEvent_CreateKey];
        _ServiceEvent_Edit                = [Serviceconfig km_safeStringForKey:kConfigEvent_EditKey];
        _ServiceTask_Create               = [Serviceconfig km_safeStringForKey:kConfigTask_CreateKey];
        _ServiceTask_Status_Change        = [Serviceconfig km_safeStringForKey:kConfigTask_Status_ChangeKey];
        _ServiceTask_Delete               = [Serviceconfig km_safeStringForKey:kConfigTask_DeleteKey];
        _ServiceFetch_class_Tasklist      = [Serviceconfig km_safeStringForKey:kConfigFetch_class_TasklistKey];
        _ServiceUpload_Material           = [Serviceconfig km_safeStringForKey:kConfigUpload_MaterialKey];
        _ServiceMaterial_Delete           = [Serviceconfig km_safeStringForKey:kConfigMaterial_DeleteKey];
        _ServiceMaterial_of_class         = [Serviceconfig km_safeStringForKey:kConfigMaterial_of_classKey];
        _Servicechange_user_password      = [Serviceconfig km_safeStringForKey:kConfigchange_user_passwordKey];
        _ServiceMyClassList               = [Serviceconfig km_safeStringForKey:kConfigMyClassListKey];
        
    }
    return self;
}

@end
