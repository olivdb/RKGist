//
//  RKGMasterViewController.h
//  RKGist
//
//  Created by Olivier van den Biggelaar on 11/01/14.
//  Copyright (c) 2014 Olivier van den Biggelaar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface RKGMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
