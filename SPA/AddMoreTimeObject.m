//
//  AddMoreTimeObject.m
//  SPA
//
//  Created by Santanu Das Adhikary on 13/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "AddMoreTimeObject.h"

@implementation AddMoreTimeObject
-(id)initWithViewtag:(NSString *)ParamViewtag
           StartTime:(NSString *)ParamStartTime
             EndTime:(NSString *)ParamEndTime
{
    self=[super init];
    if (self) {
        self.StartTime      = ParamStartTime;
        self.EndTime        = ParamEndTime;
        self.Viewtag        = ParamViewtag;
    }
    return self;
}
@end
