//
//  UserDetails.h
//  
//
//  Created by Santanu Das Adhikary on 06/11/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserDetails : NSManagedObject

@property (nonatomic, retain) NSString * sessid;
@property (nonatomic, retain) NSString * session_name;
@property (nonatomic, retain) NSString * token;
@property (nonatomic, retain) NSString * access;
@property (nonatomic, retain) NSString * created;
@property (nonatomic, retain) NSString * user_full_name;
@property (nonatomic, retain) NSString * keep_logged_in;
@property (nonatomic, retain) NSString * user_office_hours;
@property (nonatomic, retain) NSString * user_office_location;
@property (nonatomic, retain) NSString * user_phone;
@property (nonatomic, retain) NSString * user_receive_emails;
@property (nonatomic, retain) NSString * user_school;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSString * login;
@property (nonatomic, retain) NSString * mail;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * signature;
@property (nonatomic, retain) NSString * signature_format;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * theme;
@property (nonatomic, retain) NSString * timezone;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSString * picture;
@property (nonatomic, retain) NSString * roles;

@end
