//
//  SPASignoutSource.h
//  SPA
//
//  Created by Santanu Das Adhikary on 09/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPABaseSource.h"

typedef void (^SPASignoutSourceCompletionBlock)(NSDictionary* data, NSString* errorString);
@interface SPASignoutSource : NSObject
+ (SPASignoutSource*)SignoutSource;

-(void)doSignout:(NSArray *)SignoutParam completion:(SPASignoutSourceCompletionBlock)completionBlock;
@end
