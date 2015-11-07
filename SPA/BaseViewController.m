//
//  BaseViewController.m
//  SPA
//
//  Created by Santanu Das Adhikary on 04/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)CustomizeHeaderwithTitle:(NSString *)Title WithFontName:(NSString *)FontName WithFontSize:(float)Size
{
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, HeaderHeight)];
    [HeaderView setBackgroundColor:Constant.ColorSPAYellowColor];
    HeaderView.layer.masksToBounds = NO;
    HeaderView.layer.shadowOffset = CGSizeMake(0, 1);
    HeaderView.layer.shadowRadius = 10;
    HeaderView.layer.shadowOpacity = 0.4;
    HeaderView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:HeaderView];
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MenuWidth+10, 10, HeaderView.layer.frame.size.width-20, HeaderView.layer.frame.size.height-10)];
    [TitleLabel setBackgroundColor:[UIColor clearColor]];
    [TitleLabel setTextColor:Constant.ColorSPAWhiteColor];
    [TitleLabel setText:Title];
    [TitleLabel setTextAlignment:NSTextAlignmentLeft];
    [TitleLabel setFont:[UIFont fontWithName:FontName size:Size]];
    [HeaderView addSubview:TitleLabel];
}

-(void)CustomizeHeaderwithTitle:(NSString *)Title WithFontName:(NSString *)FontName WithFontSize:(float)Size WithButton:(BOOL)WithButton
{
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, HeaderHeight)];
    [HeaderView setBackgroundColor:Constant.ColorSPAYellowColor];
    HeaderView.layer.masksToBounds = NO;
    HeaderView.layer.shadowOffset = CGSizeMake(0, 1);
    HeaderView.layer.shadowRadius = 10;
    HeaderView.layer.shadowOpacity = 0.4;
    HeaderView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:HeaderView];
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MenuWidth+10, 10, HeaderView.layer.frame.size.width-20, HeaderView.layer.frame.size.height-10)];
    [TitleLabel setBackgroundColor:[UIColor clearColor]];
    [TitleLabel setTextColor:Constant.ColorSPAWhiteColor];
    [TitleLabel setText:Title];
    [TitleLabel setTextAlignment:NSTextAlignmentLeft];
    [TitleLabel setFont:[UIFont fontWithName:FontName size:Size]];
    [HeaderView addSubview:TitleLabel];
    
    if (WithButton) {
        UIButton *HeaderEditButton = [[UIButton alloc] initWithFrame:CGRectMake(HeaderView.frame.size.width-40, 25, 32, 32)];
        [HeaderEditButton setBackgroundColor:[UIColor clearColor]];
        [HeaderEditButton setImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
        [HeaderEditButton addTarget:self action:@selector(gotoEditProfile) forControlEvents:UIControlEventTouchUpInside];
        [HeaderView addSubview:HeaderEditButton];
    }
}

-(void)ShowAletviewWIthTitle:(NSString *)ParamTitle Tag:(int)ParamTag Message:(NSString *)ParamMessage CancelButtonTitle:(NSString *)ParamCancelButtonTitle OtherButtonTitle:(NSString *)ParamOtherButtonTitle
{
    UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:ParamTitle message:ParamMessage delegate:self cancelButtonTitle:ParamCancelButtonTitle otherButtonTitles:ParamOtherButtonTitle, nil];
    [AlertView setTag:ParamTag];
    [AlertView show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
