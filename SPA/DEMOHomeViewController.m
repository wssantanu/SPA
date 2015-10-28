//
//  DEMOHomeViewController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOHomeViewController.h"
#import "DEMONavigationController.h"
#import "UINavigationBar+Customnavigation.h"

@interface DEMOHomeViewController ()

@end

@implementation DEMOHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self CustomizeHeaderwithTitle:@"Header Data" WithFontName:@"Arial" WithFontSize:36 withButton:YES withSelecter:@selector(adddata) WithButtonBgImage:@"Header_PlusIcon_White"];
}

-(void)CustomizeHeaderwithTitle:(NSString *)Title WithFontName:(NSString *)FontName WithFontSize:(float)Size withButton:(BOOL)button withSelecter:(SEL)selecter WithButtonBgImage:(NSString *)WithButtonBgImage
{
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(MenuWidth, 0, [[UIScreen mainScreen] bounds].size.width-MenuWidth, 70)];
    [HeaderView setBackgroundColor:UIColorFromRGB(0x52a63d)];
    HeaderView.layer.masksToBounds = NO;
    HeaderView.layer.shadowOffset = CGSizeMake(0, 1);
    HeaderView.layer.shadowRadius = 10;
    HeaderView.layer.shadowOpacity = 0.4;
    [self.view addSubview:HeaderView];
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, HeaderView.layer.frame.size.width-45, HeaderView.layer.frame.size.height-10)];
    [TitleLabel setBackgroundColor:[UIColor clearColor]];
    [TitleLabel setTextColor:[UIColor whiteColor]];
    [TitleLabel setText:Title];
    [TitleLabel setTextAlignment:NSTextAlignmentLeft];
    [TitleLabel setFont:[UIFont fontWithName:FontName size:Size]];
    [TitleLabel setTextColor:[UIColor whiteColor]];
    [HeaderView addSubview:TitleLabel];
    
    if (button) {
        
        UIButton *HeaderButton = [[UIButton alloc] initWithFrame:CGRectMake(HeaderView.layer.frame.size.width-45, 24, 40, 40)];
        [HeaderButton setBackgroundColor:[UIColor clearColor]];
        [HeaderButton setBackgroundImage:[UIImage imageNamed:WithButtonBgImage] forState:UIControlStateNormal];
        [HeaderButton setBackgroundImage:[UIImage imageNamed:WithButtonBgImage] forState:UIControlStateApplication];
        [HeaderButton setBackgroundImage:[UIImage imageNamed:WithButtonBgImage] forState:UIControlStateHighlighted];
        [HeaderButton setBackgroundImage:[UIImage imageNamed:WithButtonBgImage] forState:UIControlStateSelected];
        [HeaderButton addTarget:self action:selecter forControlEvents:UIControlEventTouchUpInside];
        [HeaderView addSubview:HeaderButton];
        
    }
}

-(void)adddata
{
    NSLog(@"adddata ----");
}

@end
