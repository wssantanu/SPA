//
//  ClassDetails.h
//  
//
//  Created by Santanu Das Adhikary on 09/11/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClassSlots;

@interface ClassDetails : NSManagedObject

@property (nonatomic, retain) NSNumber * classId;
@property (nonatomic, retain) NSString * field_color_code;
@property (nonatomic, retain) NSString * field_end_date;
@property (nonatomic, retain) NSString * field_location;
@property (nonatomic, retain) NSString * field_section;
@property (nonatomic, retain) NSString * field_semester;
@property (nonatomic, retain) NSString * field_start_date;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * teacherFullname;
@property (nonatomic, retain) NSString * teacheremail;
@property (nonatomic, retain) NSString * teacherofficeLocation;
@property (nonatomic, retain) NSString * teacherofficehours;
@property (nonatomic, retain) NSString * techerphoneno;
@property (nonatomic, retain) ClassSlots *classslots;

@end
