//
//  SPAClassListSource.h
//  SPA
//
//  Created by Santanu Das Adhikary on 09/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPABaseSource.h"

typedef void (^SPAClassListSourceCompletionBlock)(NSDictionary* data, NSString* errorString);

@interface SPAClassListSource : NSObject

+ (SPAClassListSource*)SPAClassListSource;

-(void)getClasslist:(NSArray *)ClassListParam completion:(SPAClassListSourceCompletionBlock)completionBlock;

@end
