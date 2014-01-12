//
//  RKGGist.m
//  RKGist
//
//  Created by Olivier van den Biggelaar on 12/01/14.
//  Copyright (c) 2014 Olivier van den Biggelaar. All rights reserved.
//

#import "RKGGist.h"
#import "RKGFile.h"
#import "RKGUser.h"


@implementation RKGGist

@dynamic createdAt;
@dynamic descriptionText;
@dynamic gistID;
@dynamic htmlURL;
@dynamic jsonURL;
@dynamic public;
@dynamic updatedAt;
@dynamic files;
@dynamic user;

- (NSString *)titleText
{
    return [self.descriptionText length] ? self.descriptionText : @"(untitled)";
}

- (NSString *)subtitleText
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"MM/dd/yy '@' HH:mm a";
    });
    return [NSString stringWithFormat:@"by %@ on %@ (%d files)", self.user.login,
            [dateFormatter stringFromDate:self.createdAt], [self.files count]];
}

@end
