//
//  AppDelegate.h
//  CarePlus
//
//  Created by Avinash Tag on 10/05/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
typedef void(^LocationGet)(CLLocationCoordinate2D coordinate);


- (void) fetchLocation:(LocationGet)completion;

@end

