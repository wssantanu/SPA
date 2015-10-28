//
//  SPAStringConfig.h
//  SPA
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPAStringConfig : NSObject

+ (SPAStringConfig*)config;

@property (nonatomic, copy, readonly) NSString* Application_Name;

@end
