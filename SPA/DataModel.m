//
//  DataModel.m
//  SPA
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "DataModel.h"


@implementation DataModel {
    NSDateFormatter *dateFormatter;
}
@synthesize appDelegate = _appDelegate;
@synthesize managedObjectContext,fetchedResultsController;

+(DataModel*) sharedEngine
{
    static DataModel* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataModel alloc] init];
    });
    return instance;
}

-(id)init
{
    if((self = [super init]))
    {
        self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        requestDispatchQueue = dispatch_queue_create("com.sharlesswab.dataModel", 0);
        self.managedObjectContext = [self.appDelegate managedObjectContext];
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    return self;
}

- (void)mergeContextChangesForNotification:(NSNotification *)aNotification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.managedObjectContext mergeChangesFromContextDidSaveNotification:aNotification];
    });
}

- (void)clearCookiesForURL:(NSURL *)_URL
{
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [cookieStorage cookiesForURL:_URL];
    for (NSHTTPCookie *cookie in cookies) {
        [cookieStorage deleteCookie:cookie];
    }
}

-(NSManagedObjectContext*)getChildManagedObjectContext
{
    NSManagedObjectContext *childContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    childContext.parentContext = self.managedObjectContext;
    return childContext;
}

-(void)saveContextForChildContext:(NSManagedObjectContext*)childContext
{
    [childContext performBlockAndWait:^{
        NSError *error;
        if (![childContext save:&error]) {
            NSLog(@"Error occurred in saving child context");
        }
        [self.managedObjectContext performBlockAndWait:^{
            NSError *error;
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"Error occurred in saving parent context");
            }
        }];
    }];
}

- (NSArray *)fetchedUserDataWithUserId:(NSString *)UserId {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSArray *UserDataList;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserDetails" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(uid == %@)",UserId];
    NSLog(@"predicate=%@",predicate);
    [fetchRequest setPredicate:predicate];
    UserDataList = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return UserDataList;
}

#pragma -
#pragma - Database Queries

-(NSManagedObject*)objectOfType:(NSString*) aType forKey:(NSString*) aKey andValue:(NSString*) anId withCondition:(NSString*) aCond newFlag:(BOOL) canCreate forManagedObjectContext:(NSManagedObjectContext*)tempContext
{
    id anObj = nil;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:tempContext]];
    
    if ([aCond length] > 0)
    {
        //NSLog(@"predicate=%@",[NSString stringWithFormat:@"(%@ == %@ AND %@)",aKey,anId,aCond]);
        [request setPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(%@ == '%@' AND %@)",aKey,anId,aCond]]];
    }
    else
    {
        [request setPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(%@ == '%@')",aKey,anId]]];
    }
    NSArray* ar = [tempContext executeFetchRequest:request error:nil];
    if (ar)
    {
        int count = (int)[ar count];
        ////NSLog(@"Obj of type : %@  : count : %d %@",aType,count,request);
        if (count >0)
        {
            anObj=  [ar objectAtIndex:0];
        }
    }
    
    if (anObj == nil && canCreate)
    {
        anObj = [NSEntityDescription insertNewObjectForEntityForName:aType inManagedObjectContext:tempContext];
    }
    return anObj;
}

#pragma -
#pragma - Database Queries

-(NSManagedObject*)objectOfType:(NSString*) aType forKey:(NSString*) aKey andValue:(NSString*) anId withCondition:(NSString*) aCond newFlag:(BOOL) canCreate
{
    id anObj = nil;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:self.managedObjectContext]];
    
    if ([aCond length] > 0)
    {
        //NSLog(@"predicate=%@",[NSString stringWithFormat:@"(%@ == %@ AND %@)",aKey,anId,aCond]);
        [request setPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(%@ == '%@' AND %@)",aKey,anId,aCond]]];
    }
    else
    {
        [request setPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(%@ == '%@')",aKey,anId]]];
    }
    NSArray* ar = [self.managedObjectContext executeFetchRequest:request error:nil];
    if (ar)
    {
        int count = (int)[ar count];
        ////NSLog(@"Obj of type : %@  : count : %d %@",aType,count,request);
        if (count >0)
        {
            anObj=  [ar objectAtIndex:0];
        }
        
        if (anObj == nil && canCreate)
        {
            anObj = [NSEntityDescription insertNewObjectForEntityForName:aType inManagedObjectContext:self.managedObjectContext];
            
        }
        
        return anObj;
    }
    
    if (anObj == nil && canCreate)
    {
        anObj = [NSEntityDescription insertNewObjectForEntityForName:aType inManagedObjectContext:self.managedObjectContext];
    }
    NSLog(@"@finally");
    return anObj;
}

- (void) deleteAllObjectsForEntity:(NSString *)entityDescription
{
    NSManagedObjectContext *pManagedObjectContext=[self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:pManagedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [pManagedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items)
    {
        [pManagedObjectContext deleteObject:managedObject];
        NSLog(@"%@ object deleted",entityDescription);
    }
    
    [self.appDelegate saveContext];
}

-(NSString *) stringByStrippingHTML:(NSString*)s
{
    NSRange r;
    // NSString *s = [self copy];
    while ((r = [s rangeOfString:@"{[^>]+}" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

/**
-(BOOL)deleteEntityItem:(NSString*)entityName ForEntityId:(NSString *)entityId forPrimaryKey:(NSString *)primaryKey
{
    
    NSString *strCond=[NSString stringWithFormat:@"eventId == %@",[self.appDelegate getEventID]];
    NSLog(@"entityname=%@",entityName);
    NSLog(@"entityid==%@",entityId);
    NSLog(@"primary key=%@",primaryKey);
    id mycontentObj = [self objectOfType:entityName forKey:primaryKey andValue:entityId withCondition:strCond newFlag:NO];
    
    if (mycontentObj)
    {
        NSLog(@"fetched description=%@",[mycontentObj description]);
        [self.managedObjectContext deleteObject:mycontentObj];
        [self.appDelegate saveContext];
        return YES;
    }else{
        return NO;
    }
}
**/
@end
