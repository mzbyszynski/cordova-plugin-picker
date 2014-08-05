//
//  CDVPickerViewController.m
//  Picker
//
//  Created by Verifi Cloud Patform on 7/23/14.
//
//
#import <UIKit/UIKit.h>
#import "CDVPicker.h"
#import "CDVPickerViewController.h"


@interface CDVPickerViewController ()
{
    NSInteger selectedRow;
    NSInteger selectedComponent;
    BOOL animateSelection;

}

@property (nonatomic, strong) UITextField *pickerViewTextField;
@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation CDVPickerViewController

@synthesize pickerViewTextField = _pickerViewTextField;
@synthesize choices = _choices;
@synthesize pickerView = _pickerView;
@synthesize titleProperty = _titleProperty;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        selectedRow = 0;
        selectedComponent = 0;
        animateSelection = YES;
        self.titleProperty = @"text";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Loading view");
    
    self.pickerViewTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.pickerViewTextField];
    
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    if (self.choices.count > selectedRow)
        [self.pickerView selectRow:selectedRow inComponent:selectedComponent animated:animateSelection];
    
    self.pickerViewTextField.inputView = self.pickerView;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(cancelTouched:)];
    [toolBar setItems:[NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], closeButton, nil]];
    self.pickerViewTextField.inputAccessoryView = toolBar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showPicker {
    [self.pickerViewTextField becomeFirstResponder];
}

-(void)hidePicker {
    [self.pickerViewTextField resignFirstResponder];
    [self.plugin onPickerClose: [NSNumber numberWithLong:selectedRow] inComponent: [NSNumber numberWithLong:selectedComponent]];
}

-(void)refreshChoics {
    if (self.pickerView != nil)
        [self.pickerView reloadAllComponents];
}

- (void)cancelTouched:(UIBarButtonItem *)sender
{
    [self hidePicker];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.choices count];
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *item = [self.choices objectAtIndex:row];
    return [item objectForKey:self.titleProperty];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectedRow = row;
    selectedComponent = component;
    // perform some action
    if ([self.pickerViewTextField isFirstResponder]) {
        NSLog(@"Selected row %ld",(long)row);
        [self.plugin onPickerSelectionChange:[NSNumber numberWithLong:selectedRow] inComponent: [NSNumber numberWithLong:selectedComponent]];
    }
}

-(void)selectRow:(int)row inComponent:(NSInteger)component animated:(BOOL)animated {
    selectedRow = row;
    selectedComponent = component;
    animateSelection = animated;
   [self.pickerView selectRow:row inComponent:component animated:animated];
}

@end
