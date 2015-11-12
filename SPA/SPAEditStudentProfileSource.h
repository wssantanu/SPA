//
//  SPAEditStudentProfileSource.h
//  SPA
//
//  Created by Santanu Das Adhikary on 12/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPABaseSource.h"

typedef void (^SPAEditStudentProfileCompletionBlock)(NSDictionary* data, NSString* errorString);

@interface SPAEditStudentProfileSource : NSObject

+ (SPAEditStudentProfileSource*)editStudentProfileSource;

-(void)editStudentProfile:(NSArray *)editProfileParam withImageData:(NSData *)ImageData completion:(SPAEditStudentProfileCompletionBlock)completionBlock;

@end
