//
//  User.h
//  
//
//  Created by Avinash Tag on 11/05/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
- (void) save;
@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
