//
//  SPAsignupSource.h
//  SPA
//
//  Created by Santanu Das Adhikary on 06/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPABaseSource.h"

typedef void (^SPASignupCompletionBlock)(NSDictionary* data, NSString* errorString);

@interface SPAsignupSource : NSObject

+ (SPAsignupSource*)signupDetailsSource;

-(void)getsignupDetails:(NSArray *)signupParam withImageData:(NSData *)ImageData completion:(SPASignupCompletionBlock)completionBlock;
@end
