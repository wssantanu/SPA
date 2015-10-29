//
//  Addmoreviewobject.m
//  SPA
//
//  Created by Santanu Das Adhikary on 29/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "Addmoreviewobject.h"

@implementation Addmoreviewobject

-(id)initWithAddmoreViewTagVal:(NSString *)AddmoreViewTagVal
       AddmoreViewStartTimeVal:(NSString *)AddmoreViewStartTimeVal
         AddmoreViewEndTimeVal:(NSString *)AddmoreViewEndTimeVal
{
    self = [super init];
    if (self)
    {
        _AddmoreViewEndTimeVal      = AddmoreViewTagVal;
        _AddmoreViewStartTimeVal    = AddmoreViewStartTimeVal;
        _AddmoreViewEndTimeVal      = AddmoreViewEndTimeVal;
    }
    return self;
}
@end
