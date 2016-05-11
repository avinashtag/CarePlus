//
//  Blood+CoreDataProperties.h
//  CarePlus
//
//  Created by Avinash Tag on 11/05/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Blood.h"

NS_ASSUME_NONNULL_BEGIN

@interface Blood (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *aPositive;
@property (nullable, nonatomic, retain) NSNumber *aNegative;
@property (nullable, nonatomic, retain) NSNumber *notSet;
@property (nullable, nonatomic, retain) NSNumber *bPositive;
@property (nullable, nonatomic, retain) NSNumber *bNegative;
@property (nullable, nonatomic, retain) NSNumber *abPositive;
@property (nullable, nonatomic, retain) NSNumber *abNegative;
@property (nullable, nonatomic, retain) NSNumber *oPositive;
@property (nullable, nonatomic, retain) NSNumber *oNegative;

@end

NS_ASSUME_NONNULL_END
