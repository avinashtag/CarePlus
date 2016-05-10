//
//  PQACustomAccessoryController.h
//  PQAApp
//
//  Created by Avinash Tag on 27/11/15.
//  Copyright © 2015 Rohde & Schwarz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PQACustomAccessoryController : UIViewController

@property (strong, nonatomic) IBOutlet UIToolbar *accessoryKeyboard;
@property (strong, nonatomic) IBOutlet UIView *pickerAccessory;

typedef void(^AccessoryKeyboardResign)();
- (void) resignKeyboard:(AccessoryKeyboardResign)handler;

typedef void(^AccessoryPickerResign)(BOOL cancel, NSString *selectedText, NSInteger selectedIndex);
- (void) showPickerWithDatasource:(NSArray *)data callback: (AccessoryPickerResign)handler completionHandler:(NSString *(^)())completion;

- (void) forceResignKeyboard;
@end
