//
//  CDVPicker.h
//  Picker
//
//  Created by Verifi Cloud Patform on 7/23/14.
//
//

#import <Cordova/CDV.h>
#import "CDVPickerViewController.h"

@interface CDVPicker : CDVPlugin {
    NSString* _callbackId;
}

@property (strong, nonatomic) CDVPickerViewController* pickerController;

-(void) echo:(CDVInvokedUrlCommand*)command;
-(void) show:(CDVInvokedUrlCommand*)command;
-(void) onPickerClose:(NSNumber*)row inComponent:(NSNumber*)component;
-(void) onPickerSelectionChange:(NSNumber*)row inComponent:(NSNumber*)component;

@end
