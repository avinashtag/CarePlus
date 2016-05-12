//
//  SettingViewController.m
//  CarePlus
//
//  Created by Avinash Tag on 10/05/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

#import "SettingViewController.h"
#import "Models.h"
#import "ContactCell.h"
#import "TagCell.h"
#import "PQACustomAccessoryController.h"
#import "ContactsController.h"

typedef NS_ENUM(NSUInteger, SettingSegment) {
    Scontact = 0,
    Stags,
};

@interface SettingViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *sement;

@property (nonnull, strong) PQACustomAccessoryController *accessory;
@property (weak, nonatomic) IBOutlet UIView *contactContainer;
@property (weak, nonatomic) IBOutlet UIView *tweetController;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _dataSource = (_sement.selectedSegmentIndex == Scontact) ?[self fetchFNF]:[self fetchTags];
    [self switchSegment:_sement];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.destinationViewController isKindOfClass:[PQACustomAccessoryController class]]) {
        _accessory = segue.destinationViewController;
    }
    else if ( [segue.destinationViewController isKindOfClass:[ContactsController class]]){
        
        ContactsController *controller = segue.destinationViewController;
        [controller setAccessory:self.accessory];
    }
}


- (NSArray *)fetchTags{
    return [[ModelContext sharedContext] fetchEntities:[TweetTags class]];
}


- (IBAction)switchSegment:(UISegmentedControl *)sender {

    if (_sement.selectedSegmentIndex == Scontact) {
        [_contactContainer setHidden:NO];
        [_tweetController setHidden:YES];
    }
    else if (_sement.selectedSegmentIndex == Stags) {
        [_contactContainer setHidden:YES];
        [_tweetController setHidden:NO];
    }
}


@end
