//
//  TagsController.m
//  CarePlus
//
//  Created by Avinash Tag on 12/05/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

#import "TagsController.h"
#import "Models.h"
#import "TweetTags.h"
#import "TagCell.h"


@interface TagsController ()


@property (weak, nonatomic) IBOutlet UIView *header;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation TagsController

-(void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    _dataSource = [[ModelContext sharedContext] fetchEntities:[TweetTags class]];
    [self.tableView reloadData];
}


- (IBAction)addNewTag:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add a new tag" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Tag";
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *addTag = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        TweetTags *tweetTag = (TweetTags *) [[ModelContext sharedContext]insertEntity:[TweetTags class]];
        tweetTag.tag = [alert.textFields[0] text];
        [tweetTag save];
    }];
    
    [alert addAction: cancel];
    [alert addAction:addTag];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return _header;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  _dataSource.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"tagCellIdentifier";
    TagCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [cell.tagTitle setText:_dataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.tableView beginUpdates];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
        
        NSMutableArray *temp = [[NSMutableArray alloc]initWithArray:_dataSource];
        TweetTags *tags = _dataSource[indexPath.row];
        [[ModelContext sharedContext]removeEntity:tags];
        [temp removeObjectAtIndex:indexPath.row];
        _dataSource = temp;

        
    }
}

@end
