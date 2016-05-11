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


typedef NS_ENUM(NSUInteger, SettingSegment) {
    Scontact = 0,
    Stags,
};

@interface SettingViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *sement;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;
@property (nonnull, strong) PQACustomAccessoryController *accessory;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataSource = (_sement.selectedSegmentIndex == Scontact) ?[self fetchFNF]:[self fetchTags];
    [self.tableView reloadData];
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
}




- (NSArray *)fetchFNF{
    return [[ModelContext sharedContext] fetchEntities:[Contacts class]];
}

- (NSArray *)fetchTags{
    return [[ModelContext sharedContext] fetchEntities:[TweetTags class]];
}


- (IBAction)switchSegment:(UISegmentedControl *)sender {
    _dataSource = (_sement.selectedSegmentIndex == Scontact) ?[self fetchFNF]:[self fetchTags];
    [self.tableView reloadData];
}

-(void) saveContacts{
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _sement.selectedSegmentIndex == Scontact ? 5: _dataSource.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *contactIdentifier = @"ContactCellIdentifier";
    static NSString *tagIdentifier = @"TagCellIdentifier";
    
    
    if (_sement.selectedSegmentIndex == Scontact) {
        
        ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:contactIdentifier];
        [cell.name setDelegate:self];
        [cell.mobile setDelegate:self];
        [cell.tweetTag setDelegate:self];
        [cell.relation setDelegate:self];
        if (_dataSource.count-1 >= indexPath.row) {
            
            Contacts *contact = _dataSource[indexPath.row];
            [cell.name setText: contact.userName];
            [cell.mobile setText:[NSString stringWithFormat:@"%@",contact.mobile]];
            [cell.tweetTag setText:contact.tweetAccount];
            [cell.relation setText:contact.relation];
        }
        return cell;
    }
    else{
        TagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagIdentifier];
        
        TweetTags *tweetTag = _dataSource[indexPath.row];
        [cell.tagTitle setText:tweetTag.tag];
        return cell;
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    if (textField.tag ==4) {
        
        
        return NO;
    }
    else if (textField.tag == 2){
        [textField setInputAccessoryView:_accessory.accessoryKeyboard];
        [_accessory resignKeyboard:^{
           
            [textField resignFirstResponder];
        }];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
@end
