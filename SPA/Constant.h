//
//  Constant.h
//  SPA
//
//  Created by Santanu Das Adhikary on 16/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "LoginViewController.h"
#import "SignupController.h"
#import "ForgetPasswordControllerViewController.h"

/**
 * SPASourceConfig const
 */

#define kConfigVersionKey @"version"
#define kConfigBuildKey @"build"
#define kConfigTheMovieDbHostKey @"themoviedb_host"
#define kConfigApiKey @"api_key"
#define kConfigLoginKey @"login_parameters"

@interface Constant : NSObject

+(ViewController *)LandingController;
+(LoginViewController *)LoginViewController;
+(SignupController *)SignupController;
+(ForgetPasswordControllerViewController *)ForgetPasswordControllerViewController;

@end
