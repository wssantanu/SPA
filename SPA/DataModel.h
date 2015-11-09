//
//  DataModel.h
//  SPA
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "UserDetails.h"
#import "ClassSlots.h"
#import "ClassDetails.h"

@interface DataModel : NSObject
{
    AppDelegate* appDelegate;
    dispatch_queue_t requestDispatchQueue;
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
}

+(DataModel*) sharedEngine;

@property(nonatomic,unsafe_unretained)    AppDelegate* appDelegate;
@property (nonatomic, retain)             NSManagedObjectContext *managedObjectContext;
@property (nonatomic,retain)              NSFetchedResultsController *fetchedResultsController;


-(BOOL)isDataSynced;
-(void)performFetchRequest;
-(void)setDataSynced:(BOOL)flag;
-(void)showerrorMessage:(id)sender;
-(NSNumber*)numberForString:(NSString*)aVal;
-(void)deleteAllObjectsForEntity:(NSString *)entityDescription;
-(NSManagedObject*)objectOfType:(NSString*) aType forKey:(NSString*) aKey andValue:(NSString*) anId withCondition:(NSString*) aCond newFlag:(BOOL) canCreate forManagedObjectContext:(NSManagedObjectContext*)tempContext;
-(NSManagedObjectContext*)getChildManagedObjectContext;
-(void)saveContextForChildContext:(NSManagedObjectContext*)childContext;
-(UserDetails *)fetchCurrentUser;
-(NSArray *)fetchAllClassList;
-(ClassDetails *)fetchedClassListWithClassId:(NSString *)ClassId;
-(NSArray *)fetchedUserDataWithUserId:(NSString *)UserId;
- (NSArray *)fetchAllSlotList:(NSString *)ClassId;
@end
