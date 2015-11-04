//
//  ClassInfoViewController.m
//  SPA
//
//  Created by Santanu Das Adhikary on 04/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "ClassInfoViewController.h"

@interface ClassInfoViewController ()

@end

@implementation ClassInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:Constant.ColorSPAWhiteColor];
    
    [self CustomizeHeaderwithTitle:@"Algebra 2" WithFontName:Constant.FontRobotoBold WithFontSize:32];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
