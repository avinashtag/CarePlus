//
//  User.m
//  
//
//  Created by Avinash Tag on 11/05/16.
//
//

#import "User.h"
#import "Models.h"

@implementation User

// Insert code here to add functionality to your managed object subclass


- (void) save{
    [[ModelContext sharedContext]saveContext];
}
@end
