//
//  BiologicalSex+CoreDataProperties.h
//  CarePlus
//
//  Created by Avinash Tag on 11/05/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BiologicalSex.h"

NS_ASSUME_NONNULL_BEGIN

@interface BiologicalSex (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *sexNotSet;
@property (nullable, nonatomic, retain) NSNumber *sexFemale;
@property (nullable, nonatomic, retain) NSNumber *sexMale;
@property (nullable, nonatomic, retain) NSNumber *sexOther;

@end

NS_ASSUME_NONNULL_END
