//
//  UserDetails.h
//  
//
//  Created by Santanu Das Adhikary on 12/10/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface UserDetails : NSManagedObject

@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSNumber * userType;
@property (nonatomic, retain) NSString * userEmail;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * userSchool;
@property (nonatomic, retain) NSString * userOfficeLocation;
@property (nonatomic, retain) NSString * userOfficeHours;
@property (nonatomic, retain) NSString * userPhone;
@property (nonatomic, retain) NSString * userPhoto;
@property (nonatomic, retain) NSDate * userRegistrationDate;
@property (nonatomic, retain) NSDate * userActivationDate;
@property (nonatomic, retain) NSString * userLastLoginDate;
@property (nonatomic, retain) NSNumber * userIsLogin;
@property (nonatomic, retain) NSNumber * userReceiveEmail;

@end
