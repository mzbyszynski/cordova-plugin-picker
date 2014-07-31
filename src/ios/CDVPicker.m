//
//  CDVPicker.m
//  Picker
//
//  Created by Verifi Cloud Patform on 7/23/14.
//
//

#import "CDVPicker.h"
#import "CDVPickerViewController.h"

@implementation CDVPicker

- (void)pluginInitialize
{
    self.pickerController = [[CDVPickerViewController alloc] initWithNibName:nil bundle:nil];
    self.pickerController.plugin = self;
    [self.viewController.view insertSubview:self.pickerController.view atIndex:0];
}

// test method that just passes the first arg back to the callback, to make sure that all the wiring is working.
-(void) echo:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;
        NSString* echo = [command.arguments objectAtIndex:0];
        
        if (echo != nil && [echo length] > 0) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
        }else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

// shows the picker
-(void) show:(CDVInvokedUrlCommand*)command {
    _callbackId = command.callbackId;
    NSArray *options = [command.arguments objectAtIndex:0];
    [self pushOptionChanges:options];
    // can't run code that shows keyboard in background thread because it need a web lock on the main/web thread.
    [self.pickerController showPicker];
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = [self buildResult:@"show" keepCallback:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
     }];
}

-(void) hide:(CDVInvokedUrlCommand*)command {
    _callbackId = command.callbackId;
    [self.pickerController hidePicker];
}

-(void) updateOptions:(CDVInvokedUrlCommand*)command {
    _callbackId = command.callbackId;
    NSArray *options = [command.arguments objectAtIndex:0];
    [self pushOptionChanges:options];
    [self.pickerController refreshChoics];
    if (_callbackId != nil) {
        [self.commandDelegate runInBackground:^{
            CDVPluginResult* pluginResult = [self buildResult:@"change" keepCallback:YES];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:_callbackId];
        }];
    }
}

-(void) onPickerClose:(NSNumber*)row inComponent:(NSNumber*)component {
    if (_callbackId != nil) {
        [self.commandDelegate runInBackground:^{
            CDVPluginResult* pluginResult = [self buildResult:@"close" keepCallback:NO withRow:row inComponent:component];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:_callbackId];
            _callbackId = nil;
        }];
    }
}

-(void) pushOptionChanges:(NSArray*)options {
    self.pickerController.choices = options;
    for (int i = 0; i < options.count; i++) {
        NSDictionary *opt = [options objectAtIndex:i];
        if ([opt objectForKey:@"selected"]) {
            NSLog(@"Selecting %d",i);
            [self.pickerController selectRow:i inComponent:0 animated:YES];
        }
    }
}

-(void) onPickerSelectionChange:(NSNumber*)row inComponent:(NSNumber*)component {
    if (_callbackId != nil) {
        [self.commandDelegate runInBackground:^{
            CDVPluginResult* pluginResult = [self buildResult:@"select" keepCallback:YES withRow:row inComponent:component];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:_callbackId];
        }];
    }
}

-(CDVPluginResult*)buildResult:(NSString*)event keepCallback:(BOOL)keep {
    return [self buildResult:event keepCallback:keep withRow:nil inComponent:nil];
}

-(CDVPluginResult*)buildResult:(NSString*)event keepCallback:(BOOL)keep withRow:(NSNumber*)row inComponent:(NSNumber*)component {
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    [result setObject:event forKey:@"event"];
    if (row != nil)
        [result setObject:row forKey:@"row"];
    if (component != nil)
        [result setObject:component forKey:@"component"];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
    [pluginResult setKeepCallbackAsBool:keep];
    return pluginResult;
}

@end
