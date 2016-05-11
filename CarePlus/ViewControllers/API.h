//
//  API.h
//  CarePlus
//
//  Created by Avinash Tag on 10/05/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <HealthKit/HealthKit.h>


@interface API : NSObject
@property (nonatomic, strong, readonly) HKHealthStore *healthStore;

- (void) test;
- (void) storeHealth;
@end
