//
//  AppDelegate.h
//  SPA
//
//  Created by Santanu Das Adhikary on 09/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "REFrostedViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,REFrostedViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic,retain) UINavigationController *NavigationController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)DefaultNavigationController;
- (void)SetupAfterLoginMenu;
- (void)LogoutUser;

@end

