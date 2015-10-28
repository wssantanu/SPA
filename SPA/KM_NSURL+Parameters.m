//
//  KM_NSURL+Parameters.m
//  TheMovieDB
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "KM_NSURL+Parameters.h"


@implementation NSURL (KM_NSURL_Parameters)

+ (NSURL*)URLWithString:(NSString*)urlString additionalParameters:(NSString*)additionalParameters{
    
    NSURL* url = [NSURL URLWithString:urlString];

    BOOL alreadyHasParameters = url.query.length;
    if (alreadyHasParameters){
        urlString = [urlString stringByAppendingString:@"&"];
    } else {
        urlString = [urlString stringByAppendingString:@"?"];
    }

    urlString = [urlString stringByAppendingString:additionalParameters];

    return [NSURL URLWithString:urlString];
}


@end
