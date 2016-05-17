//
//  API.m
//  CarePlus
//
//  Created by Avinash Tag on 10/05/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

#import "API.h"
#import "AppDelegate.h"
#import <HealthKit/HealthKit.h>
#import "Models.h"
#import <Social/Social.h>
#import "NSDate+ZDate.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "BaseClass.h"

#define radius 20
#define googleType @"hospital"
#define kGOOGLE_API_KEY @"AIzaSyBvYMlqzKaL-IQj5pUEfeQTvWUmuT6UeCo"

@interface API (){
    SLComposeViewController *twitterSheet;
}

@end

@implementation API



- (void) getHopitals:(void(^)(NSArray *response))completion{
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (appdelegate.coordinate.longitude!= 0) {
       
        [self fetchHospitals:completion];
    }
    else{
        
            [appdelegate fetchLocation:^(CLLocationCoordinate2D coordinate) {
            [self fetchHospitals:completion];
        }];
    }
        
}


- (void) fetchHospitals:(void(^)(NSArray *response))completion{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    NSString *urlstring = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", appdelegate.coordinate.latitude, appdelegate.coordinate.longitude, [NSString stringWithFormat:@"%i", radius], googleType, kGOOGLE_API_KEY];
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:urlstring];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            completion(nil);
        } else {
            
            BaseClass *base = [BaseClass modelObjectWithDictionary:responseObject];
            completion(base.results);
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];

}

//
//extern NSString* CTSettingCopyMyPhoneNumber();
//
//+(NSString *) contactNumber{
//    return CTSettingCopyMyPhoneNumber();
//}


- (void) storeHealth{
    
    if ([HKHealthStore isHealthDataAvailable] == NO) {
        // If our device doesn't support HealthKit -> return.
        return;
    }
    
    
    NSArray *readTypes = @[[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth],[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBloodType]];
    
    NSArray *writeTypes = @[[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass]];
    __block User *user = (User *)[[ModelContext sharedContext]fetchEntity:[User class]];
    
    
    if ([self.healthStore authorizationStatusForType:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass]]== HKAuthorizationStatusNotDetermined) {
        
        
        [self.healthStore requestAuthorizationToShareTypes:[NSSet setWithArray:readTypes] readTypes:[NSSet setWithArray:writeTypes] completion:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                if (user) {
                    user.birthDate = [self readBirthDate];
                    user.bloodType = @([self readBloodGroup]);
                    user.biologicalSex = @([self readsex]);
                }
                else if (!user) {
                    user = (User *)[[ModelContext sharedContext] insertEntity:[User class]];
                    //                user.mobile = [API contactNumber ];
                    user.birthDate = [self readBirthDate];
                    user.bloodType = @([self readBloodGroup]);
                    user.biologicalSex = @([self readsex]);
                    [user save];
                }
            }
        }];

    }
    
    
}

- (NSDate *)readBirthDate {
    NSError *error;
    NSDate *dateOfBirth = [self.healthStore dateOfBirthWithError:&error];   // Convenience method of HKHealthStore to get date of birth directly.
    
    if (!dateOfBirth) {
        NSLog(@"Either an error occured fetching the user's age information or none has been stored yet. In your app, try to handle this gracefully.");
    }
    
    return dateOfBirth;
}

- (HKBloodType)readBloodGroup{
    
    NSError *error;
    HKBloodTypeObject *bloodType =  [self.healthStore bloodTypeWithError:&error];
    return bloodType.bloodType;
}


-(HKBiologicalSex)readsex {
    NSError *error;
    HKBiologicalSexObject *biologicalSex = [self.healthStore biologicalSexWithError:&error];
    return biologicalSex.biologicalSex;
    
}


- (void) doTweet{
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        UIViewController *controller = [[[UIApplication sharedApplication].delegate window] rootViewController];
        twitterSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        CLLocationCoordinate2D cordinate = [(AppDelegate *)[UIApplication sharedApplication].delegate coordinate];
        NSString *location = [[NSString alloc]initWithFormat:@"Please Help Me !!! Location: Lat/Long: %f/%f", cordinate.latitude, cordinate.longitude];
        NSString *message = [[NSString alloc]initWithFormat:@"%@,%@ %@",location, [self tweetText], [self tweeterTags]];
        [twitterSheet setInitialText:message];
        [twitterSheet addImage:[self tweetImage]];
        [controller presentViewController:twitterSheet animated:YES completion:nil];
    }
}


-(NSString *)tweeterTags{
    
    NSMutableArray *items = [[NSMutableArray alloc]init];
    NSArray *tags = [[ModelContext sharedContext] fetchEntities:[TweetTags class]];
    
    [tags enumerateObjectsUsingBlock:^(TweetTags  *tweet, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [items addObject: [NSString stringWithFormat:@"@%@",tweet.tag]];
    }];
    
    return [items componentsJoinedByString:@" "];
}


-(UIImage *)tweetImage{
    
    NSString *text = [NSString stringWithFormat:@"Personal Info: %@\n\n%@",[self tweetText], [self tweetImageText]];
    // set the font type and size
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:10.0f];
    NSDictionary *attributes = @{NSFontAttributeName: font};

    CGSize size  = [text sizeWithAttributes:attributes]; // label or textview
    
    // check if UIGraphicsBeginImageContextWithOptions is available (iOS is 4.0+)
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    [text drawInRect:CGRectMake(0,0,size.width,size.height) withAttributes:attributes];
    UIImage *testImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return testImg;
}


- (NSString *) tweetImageText{
    
    NSMutableArray *items = [[NSMutableArray alloc]init];
    [items addObject:@"Emergency Contacts"];
    
    NSArray *fnf = [[ModelContext sharedContext] fetchEntities:[Contacts class]];
    [fnf enumerateObjectsUsingBlock:^(Contacts  *contact, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [items addObject:[NSString stringWithFormat:@"\n"]];
        NSString *desc = [[NSString alloc]initWithFormat:@"%@, Relation: %@, Mobile: %@",contact.userName, contact.relation, contact.mobile];
        [items addObject:desc];
    }];

    return [items componentsJoinedByString:@"\n"];
}


- (NSString *) tweetText{
    
    NSMutableArray *items = [[NSMutableArray alloc]init];
    User *user = (User *)[[ModelContext sharedContext]fetchEntity:[User class]];
    [items addObject:[NSString stringWithFormat:@"%@",user.name]];
    [items addObject:[NSString stringWithFormat:@"%@",user.mobile]];
    [items addObject:[NSString stringWithFormat:@"DOB: %@",[user.birthDate dateStringInFormat:@"dd-MMM-yyyy"]]];
    
    switch (user.bloodType.integerValue) {
        case HKBloodTypeNotSet:

            break;
        case HKBloodTypeAPositive:
            [items addObject:[NSString stringWithFormat:@"A+"]];
            break;
            
        case HKBloodTypeANegative:
            [items addObject:[NSString stringWithFormat:@"A-"]];
            break;
            
        case HKBloodTypeBPositive:
            [items addObject:[NSString stringWithFormat:@"B+"]];
            break;
            
        case HKBloodTypeBNegative:
            [items addObject:[NSString stringWithFormat:@"B-"]];
            break;
            
        case HKBloodTypeABPositive:
            [items addObject:[NSString stringWithFormat:@"AB+"]];
            break;
            
        case HKBloodTypeABNegative:
            [items addObject:[NSString stringWithFormat:@"AB-"]];
            break;
            
        case HKBloodTypeOPositive:
            [items addObject:[NSString stringWithFormat:@"O+"]];
            break;
            
        case HKBloodTypeONegative:
            [items addObject:[NSString stringWithFormat:@"O-"]];
            break;
            
        default:
            break;
    }

    switch (user.biologicalSex.integerValue) {
        case HKBiologicalSexNotSet:
            
            break;
            
        case HKBiologicalSexFemale:
            [items addObject:[NSString stringWithFormat:@"Female"]];
            break;
            
        case HKBiologicalSexMale:
            [items addObject:[NSString stringWithFormat:@"Male"]];
            break;
            
        case HKBiologicalSexOther:
            [items addObject:[NSString stringWithFormat:@"Other"]];
            break;
            
        default:
            break;
    }
    return [items componentsJoinedByString:@"\n"];
}




- (void) save{
    
}
@end
