//
//  PQACustomAccessoryController.m
//  PQAApp
//
//  Created by Avinash Tag on 27/11/15.
//  Copyright © 2015 Rohde & Schwarz. All rights reserved.
//

#import "PQACustomAccessoryController.h"

@interface PQACustomAccessoryController ()
@property (nonatomic, copy) AccessoryKeyboardResign resignkeyboard;

@property (nonatomic, copy) AccessoryPickerResign resignPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (nonatomic, strong) NSArray *datasource;

@end

@implementation PQACustomAccessoryController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_pickerAccessory setBackgroundColor:[UIColor greenColor]];
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

#pragma mark - Keyboard Accessory Callback
- (void) forceResignKeyboard{
    [self doneTappedkeyboard:nil];
}

- (void) resignKeyboard:(AccessoryKeyboardResign)handler{
    _resignkeyboard = handler;
}

- (IBAction)doneTappedkeyboard:(UIBarButtonItem *)sender {
    _resignkeyboard ? _resignkeyboard():nil;
}

#pragma mark - Picker Accessory Callback

- (void) showPickerWithDatasource:(NSArray *)data callback:(AccessoryPickerResign)handler completionHandler:(NSString *(^)())completion{
    _resignPicker = handler;
    _datasource = data;
    [_picker reloadAllComponents];
    [self doneTappedkeyboard:nil];
    if (completion) {
        NSString *selected = completion();
        NSInteger indexSelected = [data indexOfObject:selected];
        indexSelected != NSNotFound ? [_picker selectRow:indexSelected inComponent:0 animated:NO]  : nil;
    }
}

- (IBAction)cancelTappedPicker:(UIBarButtonItem *)sender {
    
    _resignPicker ? _resignPicker(YES,nil,0):nil;
}

- (IBAction)doneTappedPicker:(UIBarButtonItem *)sender {
    NSInteger index = [_picker selectedRowInComponent:0];
    _resignPicker ? _resignPicker(NO,_datasource[index],index):nil;
}

#pragma mark - Picker Datasource & Delegates

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _datasource.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _datasource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}


@end
