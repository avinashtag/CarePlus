//
//  HomeViewController.m
//  CarePlus
//
//  Created by Avinash Tag on 10/05/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

#import "HomeViewController.h"
#import "HospitalCell.h"
#import "Models.h"
#import "API.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"
#import "DataModels.h"
#import <MBProgressHUD.h>


@interface HomeViewController ()<MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *hospitalsTable;
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) API *api;
@property (strong, nonatomic) IBOutlet UIView *customNav;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.hospitalsTable.rowHeight = UITableViewAutomaticDimension;
    self.hospitalsTable.estimatedRowHeight = 61.0;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES ];
    _api = [[API alloc]init];
    [_api storeHealth];
    [_api getHopitals:^(NSArray *response) {
       
        _dataSource = response;
        [self.hospitalsTable reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES ];

    }];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self.navigationController.navigationBar addSubview:_customNav];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  _dataSource.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"ContactCellIdentifier";
    HospitalCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Result* result = _dataSource[indexPath.row];

    [cell callingHospital:^{
        
        NSString *phoneNumber = [@"tel://" stringByAppendingString:result.formattedPhoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }];
    
    [cell.hospitalName setText:result.name];
    
    NSMutableArray *descArray = [[NSMutableArray alloc]init];
    
    [descArray addObject:[NSString stringWithFormat:@"Website: %@",result.website]];
    [descArray addObject:[NSString stringWithFormat:@"Address: %@",result.formattedAddress]];
//    [descArray addObject:[NSString stringWithFormat:@"Open Now: %@",result.openingHours.openNow?@"YES": @"NO"]];
//    [descArray addObject:[NSString stringWithFormat:@"Opening Hours: %@",[result.openingHours.weekdayText componentsJoinedByString:@","]]];
    [descArray addObject:[NSString stringWithFormat:@"Types: %@",[result.types componentsJoinedByString:@","]]];
    
    [cell.hopitalDescription setText:[descArray componentsJoinedByString:@"\n"]];
    [cell.hopitalDescription sizeToFit];
    return cell;
}


- (IBAction)panicPressed:(id)sender{
    
    __block NSMutableArray *recipient = [[NSMutableArray alloc]init];
    NSArray *temp = [[ModelContext sharedContext] fetchEntities:[Contacts class]];
    if (temp.count) {
        
        [temp enumerateObjectsUsingBlock:^(Contacts  *contact, NSUInteger idx, BOOL * _Nonnull stop) {
            [recipient addObject:[NSString stringWithFormat:@"%@",contact.mobile]];
        }];
        
        CLLocationCoordinate2D cordinate = [(AppDelegate *)[UIApplication sharedApplication].delegate coordinate];
        NSString *message = [[NSString alloc]initWithFormat:@"Please Help Me !!! Location: Lat/Long: %f/%f", cordinate.latitude, cordinate.longitude];
        [ self sendSMS:message recipientList:recipient];

    }
    else{
        [_api doTweet];
    }
    
}



- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = bodyOfMessage;
        controller.recipients = recipients;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [_api doTweet];

    if (result == MessageComposeResultCancelled){
        NSLog(@"Message cancelled");
        
    }
    else if (result == MessageComposeResultSent){
     
        NSLog(@"Message sent");
    }
    else{
        NSLog(@"Message failed");
    }

}


@end
