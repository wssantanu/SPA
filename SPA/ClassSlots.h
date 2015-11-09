//
//  ClassSlots.h
//  
//
//  Created by Santanu Das Adhikary on 09/11/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClassDetails;

@interface ClassSlots : NSManagedObject

@property (nonatomic, retain) NSNumber * classId;
@property (nonatomic, retain) NSString * end_time;
@property (nonatomic, retain) NSString * start_time;
@property (nonatomic, retain) NSString * dayId;
@property (nonatomic, retain) ClassDetails *classdetails;

@end
