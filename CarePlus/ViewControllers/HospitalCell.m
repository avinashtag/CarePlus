//
//  HospitalCell.m
//  CarePlus
//
//  Created by Avinash Tag on 10/05/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

#import "HospitalCell.h"

@interface HospitalCell ()

@property (nonatomic, copy) Call callCompletion;
@end

@implementation HospitalCell

- (IBAction)doCallHospital:(UIButton *)sender {
    if (_callCompletion) {
        _callCompletion();
    }
}

- (void)callingHospital:(Call)completion{
    _callCompletion = completion;
}
@end
