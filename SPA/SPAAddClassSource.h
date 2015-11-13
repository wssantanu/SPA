//
//  SPAAddClassSource.h
//  SPA
//
//  Created by Santanu Das Adhikary on 13/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPABaseSource.h"

typedef void (^SPAAddClassCompletionBlock)(NSDictionary* data, NSString* errorString);

@interface SPAAddClassSource : NSObject

+ (SPAAddClassSource*)addClassSource;

-(void)saveClassDetails:(NSArray *)saveClassParam completion:(SPAAddClassCompletionBlock)completionBlock;

@end
