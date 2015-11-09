//
//  SPAChangePasswordSource.h
//  SPA
//
//  Created by Santanu Das Adhikary on 09/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPABaseSource.h"

typedef void (^SPAChangePasswordCompletionBlock)(NSDictionary* data, NSString* errorString);

@interface SPAChangePasswordSource : NSObject

+ (SPAChangePasswordSource*)ChangePasswordSource;

-(void)doChangePassword:(NSArray *)ChangePasswordParam completion:(SPAChangePasswordCompletionBlock)completionBlock;
@end
