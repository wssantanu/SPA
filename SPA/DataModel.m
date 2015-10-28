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

@end
