//
//  CafyneApiClient.h
//  Cafyne
//
//  Created by Ashish Kumar on 02/12/14.
//  Copyright (c) 2014 Cafyne. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface CafyneApiClient : AFHTTPRequestOperationManager

//Share instance
+ (instancetype)sharedClient;
+ (instancetype)sharedBasicLoginClient;

@end
