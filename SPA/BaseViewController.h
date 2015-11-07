//
//  BaseViewController.h
//  SPA
//
//  Created by Santanu Das Adhikary on 04/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

-(void)CustomizeHeaderwithTitle:(NSString *)Title WithFontName:(NSString *)FontName WithFontSize:(float)Size;
-(void)ShowAletviewWIthTitle:(NSString *)ParamTitle Tag:(int)ParamTag Message:(NSString *)ParamMessage CancelButtonTitle:(NSString *)ParamCancelButtonTitle OtherButtonTitle:(NSString *)ParamOtherButtonTitle;
-(void)CustomizeHeaderwithTitle:(NSString *)Title WithFontName:(NSString *)FontName WithFontSize:(float)Size WithButton:(BOOL)WithButton;
@end
