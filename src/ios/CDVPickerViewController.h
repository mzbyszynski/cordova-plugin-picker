//
//  CDVPickerViewController.h
//  Picker
//
//  Created by Verifi Cloud Patform on 7/23/14.
//
//

#import <UIKit/UIKit.h>

@class CDVPicker;

@interface CDVPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong,nonatomic) CDVPicker* plugin;
@property (strong, nonatomic) NSArray* choices;

-(void)showPicker;

-(void)hidePicker;

-(void)selectRow:(int)row inComponent:(NSInteger)component animated:(BOOL)animated;

-(void)refreshChoics;

@end
