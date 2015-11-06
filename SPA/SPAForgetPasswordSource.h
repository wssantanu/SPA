//
//  SPAForgetPasswordSource.h
//  SPA
//
//  Created by Santanu Das Adhikary on 06/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPABaseSource.h"

typedef void (^SPAForgetPasswordCompletionBlock)(NSDictionary* data, NSString* errorString);

@interface SPAForgetPasswordSource : NSObject

+ (SPAForgetPasswordSource*)ForgetPasswordDetailsSource;

-(void)getForgetPasswordDetails:(NSArray *)ForgetPasswordParam completion:(SPAForgetPasswordCompletionBlock)completionBlock;

@end
