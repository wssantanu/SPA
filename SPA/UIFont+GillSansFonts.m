//
//  UIFont+GillSansFonts.m
//  TheMovieDB
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "UIFont+GillSansFonts.h"

@implementation UIFont (RotoboFonts)

+ (UIFont*)gillSansBoldFontWithSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"GillSans-Bold" size:fontSize];
}

+ (UIFont*)gillSansMediumFontWithSize:(CGFloat)fontSize
{
    return  [UIFont fontWithName:@"GillSans-Medium" size:fontSize];
}

+ (UIFont*)gillSansRegularFontWithSize:(CGFloat)fontSize
{
    return  [UIFont fontWithName:@"GillSans-Regular" size:fontSize];
}

+ (UIFont*)gillSansLightFontWithSize:(CGFloat)fontSize;
{
    return  [UIFont fontWithName:@"GillSans-Light" size:fontSize];
}

@end
