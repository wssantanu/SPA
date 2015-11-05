//
//  SPALoginSource.h
//  SPA
//
//  Created by Santanu Das Adhikary on 05/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPABaseSource.h"
#import "KMMovie.h"

typedef void (^SPALoginCompletionBlock)(NSDictionary* data, NSString* errorString);

@interface SPALoginSource : SPABaseSource

+ (SPALoginSource*)loginDetailsSource;

-(void)getLoginDetails:(NSArray *)LoginParam completion:(SPALoginCompletionBlock)completionBlock;

@end
