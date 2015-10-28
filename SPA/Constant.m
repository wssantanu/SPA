//
//  Constant.m
//  SPA
//
//  Created by Santanu Das Adhikary on 16/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "Constant.h"

@implementation Constant

+(ViewController *)LandingController {
    return [[ViewController alloc] initWithNibName:@"ViewController" bundle:[NSBundle mainBundle]];
}
+(LoginViewController *)LoginViewController {
    return [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
}
+(SignupController *)SignupController {
    return [[SignupController alloc] initWithNibName:@"SignupController" bundle:[NSBundle mainBundle]];
}
+(ForgetPasswordControllerViewController *)ForgetPasswordControllerViewController {
    return [[ForgetPasswordControllerViewController alloc] initWithNibName:@"ForgetPasswordControllerViewController" bundle:[NSBundle mainBundle]];
}
@end
