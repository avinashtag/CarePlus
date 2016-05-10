//
//  API.m
//  CarePlus
//
//  Created by Avinash Tag on 10/05/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

#import "API.h"
#import "AppDelegate.h"


#define radius 20
#define googleType @"hospital"
#define kGOOGLE_API_KEY @"AIzaSyBf6ZER2bBfyflhYRK0XNs2bbEol-EBvFM"
@implementation API



- (void) test{
    
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
     NSString *urlstring = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", appdelegate.coordinate.latitude, appdelegate.coordinate.longitude, [NSString stringWithFormat:@"%i", radius], googleType, kGOOGLE_API_KEY];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:urlstring];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];
}


- (void) save{
    
}
@end
