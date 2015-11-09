//
//  KMSourceConfig.h
//  TheMovieDB
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPASourceConfig : NSObject

+ (SPASourceConfig*)config;

@property (nonatomic, copy, readonly) NSString* version;
@property (nonatomic, copy, readonly) NSString* build;
@property (nonatomic, copy, readonly) NSString* theDbHost;
@property (nonatomic, copy, readonly) NSString* apiKey;
@property (nonatomic, copy, readonly) NSString* SeperatorKey;

@property (nonatomic, copy, readonly) NSString* Paramlogin_parameters;
@property (nonatomic, copy, readonly) NSString* Paramrequest_newpassword;
@property (nonatomic, copy, readonly) NSString* Paramlogout;
@property (nonatomic, copy, readonly) NSString* ParamUser_Registration;
@property (nonatomic, copy, readonly) NSString* ParamClass_Create;
@property (nonatomic, copy, readonly) NSString* ParamClass_Edit;
@property (nonatomic, copy, readonly) NSString* ParamFetch_Class_list;
@property (nonatomic, copy, readonly) NSString* ParamEvent_Create;
@property (nonatomic, copy, readonly) NSString* ParamEvent_Edit;
@property (nonatomic, copy, readonly) NSString* ParamTask_Create;
@property (nonatomic, copy, readonly) NSString* ParamTask_Status_Change;
@property (nonatomic, copy, readonly) NSString* ParamTask_Delete;
@property (nonatomic, copy, readonly) NSString* ParamFetch_class_Tasklist;
@property (nonatomic, copy, readonly) NSString* ParamUpload_Material;
@property (nonatomic, copy, readonly) NSString* ParamMaterial_Delete;
@property (nonatomic, copy, readonly) NSString* ParamMaterial_of_class;
@property (nonatomic, copy, readonly) NSString* Paramchange_user_password;
@property (nonatomic, copy, readonly) NSString* ParamMyClassList;

@property (nonatomic, copy, readonly) NSString* Servicelogin_parameters;
@property (nonatomic, copy, readonly) NSString* Servicerequest_newpassword;
@property (nonatomic, copy, readonly) NSString* Servicelogout;
@property (nonatomic, copy, readonly) NSString* ServiceUser_Registration;
@property (nonatomic, copy, readonly) NSString* ServiceClass_Create;
@property (nonatomic, copy, readonly) NSString* ServiceClass_Edit;
@property (nonatomic, copy, readonly) NSString* ServiceFetch_Class_list;
@property (nonatomic, copy, readonly) NSString* ServiceEvent_Create;
@property (nonatomic, copy, readonly) NSString* ServiceEvent_Edit;
@property (nonatomic, copy, readonly) NSString* ServiceTask_Create;
@property (nonatomic, copy, readonly) NSString* ServiceTask_Status_Change;
@property (nonatomic, copy, readonly) NSString* ServiceTask_Delete;
@property (nonatomic, copy, readonly) NSString* ServiceFetch_class_Tasklist;
@property (nonatomic, copy, readonly) NSString* ServiceUpload_Material;
@property (nonatomic, copy, readonly) NSString* ServiceMaterial_Delete;
@property (nonatomic, copy, readonly) NSString* ServiceMaterial_of_class;
@property (nonatomic, copy, readonly) NSString* Servicechange_user_password;
@property (nonatomic, copy, readonly) NSString* ServiceMyClassList;

@end
