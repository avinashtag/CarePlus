//
//  ContactCell.h
//  CarePlus
//
//  Created by Avinash Tag on 10/05/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *mobile;
@property (weak, nonatomic) IBOutlet UITextField *tweetTag;
@property (weak, nonatomic) IBOutlet UITextField *relation;
@end
