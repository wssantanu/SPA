//
//  UINavigationBar+Customnavigation.m
//  REFrostedViewControllerExample
//
//  Created by Santanu Das Adhikary on 27/10/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

#import "UINavigationBar+Customnavigation.h"

@implementation UINavigationBar (Customnavigation)

-(void)MakeCustomize
{
    [self setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 65)];
    
    [self setTitleVerticalPositionAdjustment:-5 forBarMetrics:UIBarMetricsDefault];
    
    [self setBarTintColor:[UIColor greenColor]];
    
    NSString *TitleString = self.topItem.title;
    
    UIView *TopbarBackgroundView =[[UIView alloc] initWithFrame:CGRectMake(-15, -3, [[UIScreen mainScreen] bounds].size.width-120, 55)];
    
    [TopbarBackgroundView setBackgroundColor:[UIColor clearColor]];
    
    self.topItem.titleView = TopbarBackgroundView;
    
    UILabel *TopbarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(-20, TopbarBackgroundView.frame.origin.y, TopbarBackgroundView.frame.size.width, TopbarBackgroundView.frame.size.height)];
    [TopbarTitleLabel setBackgroundColor:[UIColor clearColor]];
    if (TitleString.length>0) {
        [TopbarTitleLabel setText:[TitleString capitalizedString]];
    }
    [TopbarTitleLabel setTextColor:[UIColor whiteColor]];
    [TopbarTitleLabel setFont:[UIFont fontWithName:@"Helvetica-bold" size:17.0]];
    [TopbarBackgroundView addSubview:TopbarTitleLabel];
}

@end
