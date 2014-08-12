//
//  CDVPicker.h
//  Picker
//
//

#import <Cordova/CDV.h>
#import "CDVPickerViewController.h"

@interface CDVPicker : CDVPlugin {
    NSString* _callbackId;
}

@property (strong, nonatomic) CDVPickerViewController* pickerController;
@property (nonatomic, assign) BOOL enableBackButton;
@property (nonatomic, assign) BOOL enableForwardButton;

-(void) echo:(CDVInvokedUrlCommand*)command;
-(void) show:(CDVInvokedUrlCommand*)command;
-(void) hide:(CDVInvokedUrlCommand*)command;
-(void) updateOptions:(CDVInvokedUrlCommand*)command;
-(void) onPickerClose:(NSNumber*)row inComponent:(NSNumber*)component;
-(void) onPickerSelectionChange:(NSNumber*)row inComponent:(NSNumber*)component;
-(void) onGoToNext;
-(void) onGoToPrevious;

@end
