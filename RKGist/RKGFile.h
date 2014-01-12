//
//  RKGFile.h
//  RKGist
//
//  Created by Olivier van den Biggelaar on 12/01/14.
//  Copyright (c) 2014 Olivier van den Biggelaar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RKGGist;

@interface RKGFile : NSManagedObject

@property (nonatomic, retain) NSString * filename;
@property (nonatomic, retain) id rawURL;
@property (nonatomic, retain) NSNumber * size;
@property (nonatomic, retain) RKGGist *gist;

@end
