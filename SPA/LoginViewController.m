//
//  LoginViewController.m
//  SPA
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "LoginViewController.h"
#import "SignupController.h"
#import "StoryBoardUtilities.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIButton *LoginButton = ([[self.view viewWithTag:121] isKindOfClass:[UIButton class]])?(UIButton *)[self.view viewWithTag:121]:nil;
    [LoginButton addTarget:self action:@selector(GotoSignupOne) forControlEvents:UIControlEventTouchUpInside];
}
-(void)GotoSignup
{
    UIViewController *NextView = [StoryBoardUtilities viewControllerForStoryboardName:@"LoginflowStoryboard" class:[SignupController class]];
    [self.navigationController pushViewController:NextView animated:YES];
}
-(void)GotoSignupOne
{
    SignupController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"SignupController"];
    [self.navigationController pushViewController:newView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
