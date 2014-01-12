//
//  RKGAppDelegate.m
//  RKGist
//
//  Created by Olivier van den Biggelaar on 11/01/14.
//  Copyright (c) 2014 Olivier van den Biggelaar. All rights reserved.
//

#import "RKGAppDelegate.h"
#import "RKGMasterViewController.h"

@implementation RKGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSError *error = nil;
    NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"RKGist" ofType:@"momd"]];
    // NOTE: Due to an iOS 5 bug, the managed object model returned is immutable.
    NSManagedObjectModel *managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    // Initialize the Core Data stack
    [managedObjectStore createPersistentStoreCoordinator];
    
    NSPersistentStore __unused *persistentStore = [managedObjectStore addInMemoryPersistentStore:&error];
    NSAssert(persistentStore, @"Failed to add persistent store: %@", error);
    
    [managedObjectStore createManagedObjectContexts];
    
    // Set the default store shared instance
    [RKManagedObjectStore setDefaultStore:managedObjectStore];
    
    //
    // Configure the object manager
    //
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"https://api.github.com"]];
    objectManager.managedObjectStore = managedObjectStore;
    [RKObjectManager setSharedManager:objectManager];
    
    RKEntityMapping *gistMapping = [RKEntityMapping mappingForEntityForName:@"Gist" inManagedObjectStore:managedObjectStore];
    [gistMapping addAttributeMappingsFromDictionary:@{
                                                        @"id":             @"gistID",
                                                        @"url":            @"jsonURL",
                                                        @"description":    @"descriptionText",
                                                        @"public":         @"public",
                                                        @"created_at":     @"createdAt"}];
    gistMapping.identificationAttributes = @[ @"gistID" ];
    
    RKEntityMapping *userMapping = [RKEntityMapping mappingForEntityForName:@"User" inManagedObjectStore:managedObjectStore];
    [userMapping addAttributeMappingsFromDictionary:@{
                                                        @"id":             @"userID",
                                                        @"gravatar_id":    @"gravatarID",
                                                        @"login":          @"login",
                                                        @"avatar_url":     @"avatarURL",
                                                        @"url":            @"jsonURL"}];
    userMapping.identificationAttributes = @[ @"userID" ];
    
    RKEntityMapping *fileMapping = [RKEntityMapping mappingForEntityForName:@"File" inManagedObjectStore:managedObjectStore];
    fileMapping.forceCollectionMapping = YES;
    [fileMapping addAttributeMappingFromKeyOfRepresentationToAttribute:@"filename"];
    [fileMapping addAttributeMappingsFromDictionary:@{
                                                        @"(filename).size":        @"size",
                                                        @"(filename).raw_url":     @"rawURL"}];
    
    [gistMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"user" toKeyPath:@"user" withMapping:userMapping]];
    [gistMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"files" toKeyPath:@"files" withMapping:fileMapping]];
    
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:gistMapping
                                                                                            method:RKRequestMethodAny
                                                                                       pathPattern:@"/gists/public"
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseDescriptor];
    //
    //
    
    // Override point for customization after application launch.
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    RKGMasterViewController *controller = (RKGMasterViewController *)navigationController.topViewController;
    controller.managedObjectContext = managedObjectStore.mainQueueManagedObjectContext;
    return YES;
}

@end
