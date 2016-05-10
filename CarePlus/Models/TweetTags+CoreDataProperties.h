//
//  TweetTags+CoreDataProperties.h
//  CarePlus
//
//  Created by Avinash Tag on 10/05/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TweetTags.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetTags (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *tag;

@end

NS_ASSUME_NONNULL_END
