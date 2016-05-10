//
//  Contacts.m
//  CarePlus
//
//  Created by Avinash Tag on 10/05/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

#import "Contacts.h"
#import "ModelContext.h"


@implementation Contacts

// Insert code here to add functionality to your managed object subclass


+ (NSArray *) allContacts{
    return [[ModelContext sharedContext] fetchEntities:[self class]];
}


- (void) save{
    [[ModelContext sharedContext]saveContext];
}


@end
