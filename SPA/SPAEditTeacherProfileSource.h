//
//  SPAEditTeacherProfileSource.h
//  SPA
//
//  Created by Santanu Das Adhikary on 12/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPABaseSource.h"

typedef void (^SPAEditTeacherProfileCompletionBlock)(NSDictionary* data, NSString* errorString);

@interface SPAEditTeacherProfileSource : NSObject

+ (SPAEditTeacherProfileSource*)editTeacherProfileSource;

-(void)editTeacherProfile:(NSArray *)editProfileParam withImageData:(NSData *)ImageData completion:(SPAEditTeacherProfileCompletionBlock)completionBlock;

@end
