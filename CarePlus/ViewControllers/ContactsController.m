//
//  ContactsController.m
//  CarePlus
//
//  Created by Avinash Tag on 12/05/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

#import "ContactsController.h"
#import "ContactCell.h"
#import "Models.h"
#import "NSString+TString.h"

#define validationTitle @"Validation Failed"

@interface ContactsController ()

@property (weak, nonatomic) IBOutlet ContactCell *fnf1;
@property (weak, nonatomic) IBOutlet ContactCell *fnf2;
@property (weak, nonatomic) IBOutlet ContactCell *fnf3;
@property (weak, nonatomic) IBOutlet ContactCell *fnf4;
@property (weak, nonatomic) IBOutlet ContactCell *fnf5;

@property (nonatomic, strong) NSArray *dataSource;

@end


@implementation ContactsController

-(void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    _dataSource = [[ModelContext sharedContext] fetchEntities:[Contacts class]];
    
    [_dataSource enumerateObjectsUsingBlock:^(Contacts  *contact, NSUInteger idx, BOOL * _Nonnull stop) {
        
        switch (idx) {
            case 0:
            {
                [_fnf1.name setText: contact.userName];
                [_fnf1.mobile setText:[NSString stringWithFormat:@"%@",contact.mobile]];
                [_fnf1.tweetTag setText:contact.tweetAccount];
                [_fnf1.relation setText:contact.relation];
            }
                break;
            
            case 1:
            {
                [_fnf2.name setText: contact.userName];
                [_fnf2.mobile setText:[NSString stringWithFormat:@"%@",contact.mobile]];
                [_fnf2.tweetTag setText:contact.tweetAccount];
                [_fnf2.relation setText:contact.relation];
            }
                break;

            case 2:
            {
                [_fnf3.name setText: contact.userName];
                [_fnf3.mobile setText:[NSString stringWithFormat:@"%@",contact.mobile]];
                [_fnf3.tweetTag setText:contact.tweetAccount];
                [_fnf3.relation setText:contact.relation];
            }
                break;

            case 3:
            {
                [_fnf4.name setText: contact.userName];
                [_fnf4.mobile setText:[NSString stringWithFormat:@"%@",contact.mobile]];
                [_fnf4.tweetTag setText:contact.tweetAccount];
                [_fnf4.relation setText:contact.relation];
            }
                break;

            case 4:
            {
                [_fnf5.name setText: contact.userName];
                [_fnf5.mobile setText:[NSString stringWithFormat:@"%@",contact.mobile]];
                [_fnf5.tweetTag setText:contact.tweetAccount];
                [_fnf5.relation setText:contact.relation];
            }
                break;

            default:
                break;
        }
        
    }];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField.tag == 2){
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



- (void) showAlert:(NSString *)title message:(NSString *)message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)validatePass:(ContactCell *)cell{
    if ([cell.name.text isBlank] && [cell.mobile.text isBlank] &&  [cell.relation.text isBlank]) {
        return NO;
    }
    return YES;
}

- (BOOL)validate:(ContactCell *)cell{
    
    BOOL valid = NO;
    if ([cell.name.text isBlank]) {
        [self showAlert:validationTitle message:@"Please fill the name."];
    }
    else if ([cell.mobile.text isBlank]) {
        [self showAlert:validationTitle message:@"Please fill contact number."];
    }
    else if ([cell.relation.text isBlank]) {
        [self showAlert:validationTitle message:@"Please mention a relation with contact person."];
    }
    else
        valid = YES;
    
    return valid;
}

- (void) saveContact:(ContactCell *)cell index:(NSInteger)index{
  
    Contacts *contact = _dataSource.count>index ? _dataSource[index]: [[ModelContext sharedContext] insertEntity:[Contacts class]];
    
    contact.userName = cell.name.text;
    contact.mobile = @([[cell.mobile.text stringByReplacingOccurrencesOfString:@"+" withString:@"0"] doubleValue]);
    contact.tweetAccount = cell.tweetTag.text;
    contact.relation = cell.relation.text;
    [contact save];
}

-(void)saveContacts{
    
    if ([self validatePass:_fnf1] && [self validate:_fnf1]) {
        
        [self saveContact:_fnf1 index:0];
    }
    if ([self validatePass:_fnf2] && [self validate:_fnf2]) {
        
        [self saveContact:_fnf2 index:1];
    }
    if ([self validatePass:_fnf3] && [self validate:_fnf3]) {
        
        [self saveContact:_fnf3 index:2];
    }
    if ([self validatePass:_fnf4] && [self validate:_fnf4]) {
        
        [self saveContact:_fnf4 index:3];
    }
    if ([self validatePass:_fnf5] && [self validate:_fnf5]) {
        
        [self saveContact:_fnf5 index:4];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
