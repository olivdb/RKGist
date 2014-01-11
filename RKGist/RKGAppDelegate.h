//
//  RKGAppDelegate.h
//  RKGist
//
//  Created by Olivier van den Biggelaar on 11/01/14.
//  Copyright (c) 2014 Olivier van den Biggelaar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
