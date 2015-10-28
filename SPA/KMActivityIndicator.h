//
//  KMActivityIndicator.h
//  
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface KMActivityIndicator : UIView

@property (nonatomic) BOOL hidesWhenStopped;
@property (nonatomic, strong) UIColor *color;

-(void)startAnimating;
-(void)stopAnimating;
-(BOOL)isAnimating;

@end
