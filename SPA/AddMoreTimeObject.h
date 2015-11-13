//
//  AddMoreTimeObject.h
//  SPA
//
//  Created by Santanu Das Adhikary on 13/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddMoreTimeObject : NSObject
@property (nonatomic,retain) NSString *Viewtag;
@property (nonatomic,retain) NSString *StartTime;
@property (nonatomic,retain) NSString *EndTime;
-(id)initWithViewtag:(NSString *)ParamViewtag
           StartTime:(NSString *)ParamStartTime
             EndTime:(NSString *)ParamEndTime;
@end
