//
//  HospitalCell.h
//  CarePlus
//
//  Created by Avinash Tag on 10/05/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HospitalCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *hospitalName;
@property (weak, nonatomic) IBOutlet UILabel *hopitalDescription;


typedef void(^Call)();
- (IBAction)doCallHospital:(UIButton *)sender;

- (void) callingHospital:(Call)completion;
@end
