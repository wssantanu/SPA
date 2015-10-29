//
//  Addmoreviewobject.h
//  SPA
//
//  Created by Santanu Das Adhikary on 29/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Addmoreviewobject : NSObject

@property (nonatomic,retain) NSString *AddmoreViewTagVal;
@property (nonatomic,retain) NSString *AddmoreViewStartTimeVal;
@property (nonatomic,retain) NSString *AddmoreViewEndTimeVal;

-(id)initWithAddmoreViewTagVal:(NSString *)AddmoreViewTagVal
       AddmoreViewStartTimeVal:(NSString *)AddmoreViewStartTimeVal
         AddmoreViewEndTimeVal:(NSString *)AddmoreViewEndTimeVal;
@end
