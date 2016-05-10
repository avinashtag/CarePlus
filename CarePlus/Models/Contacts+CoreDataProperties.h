//
//  Contacts+CoreDataProperties.h
//  CarePlus
//
//  Created by Avinash Tag on 10/05/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Contacts.h"

NS_ASSUME_NONNULL_BEGIN

@interface Contacts (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *mobile;
@property (nullable, nonatomic, retain) NSString *relation;
@property (nullable, nonatomic, retain) NSString *tweetAccount;
@property (nullable, nonatomic, retain) NSString *userName;

@end

NS_ASSUME_NONNULL_END
