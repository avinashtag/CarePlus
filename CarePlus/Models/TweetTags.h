//
//  TweetTags.h
//  CarePlus
//
//  Created by Avinash Tag on 10/05/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface TweetTags : NSManagedObject

// Insert code here to declare functionality of your managed object subclass


+ (NSArray *) allTags;
- (void) save;


@end

NS_ASSUME_NONNULL_END

#import "TweetTags+CoreDataProperties.h"
