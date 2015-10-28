//
//  KM_NSURL+Parameters.h
//  TheMovieDB
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSURL (KM_NSURL_Parameters)

+ (NSURL*)URLWithString:(NSString*)urlString additionalParameters:(NSString*)additionalParameters;

@end
