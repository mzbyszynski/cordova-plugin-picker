//
//  CDVPicker.m
//  Picker
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
    self.enableBackButton = NO;
    self.enableForwardButton= NO;
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
    NSArray* options = [command.arguments objectAtIndex:0];
    NSInteger selectedIndex = 0;
    if (command.arguments.count > 1)
        selectedIndex = [[command.arguments objectAtIndex:1] integerValue];
    if (command.arguments.count > 2)
        self.enableBackButton = [[command.arguments objectAtIndex:2] boolValue];
    if (command.arguments.count > 3)
        self.enableForwardButton = [[command.arguments objectAtIndex:3] boolValue];
    NSLog(@"showing with selected row %ld, back buttonenabled: %d", selectedIndex, self.enableBackButton);
    [self pushOptionChanges:options withSelectedRow:selectedIndex];
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
    NSInteger selectedIndex = 0;
    if (command.arguments.count > 1)
        selectedIndex = [[command.arguments objectAtIndex:1] integerValue];
    if (command.arguments.count > 2)
        self.enableBackButton = [[command.arguments objectAtIndex:2] boolValue];
    if (command.arguments.count > 3)
        self.enableForwardButton = [[command.arguments objectAtIndex:3] boolValue];
    [self pushOptionChanges:options withSelectedRow:selectedIndex];
    [self.pickerController refreshChoices];
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

-(void) onGoToNext {
    if (_callbackId != nil) {
        [self.commandDelegate runInBackground:^{
            CDVPluginResult* pluginResult = [self buildResult:@"next" keepCallback:NO];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:_callbackId];
            _callbackId = nil;
        }];
    }
}

-(void) onGoToPrevious {
    if (_callbackId != nil) {
        [self.commandDelegate runInBackground:^{
            CDVPluginResult* pluginResult = [self buildResult:@"back" keepCallback:NO];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:_callbackId];
            _callbackId = nil;
        }];
    }
}

-(void) pushOptionChanges:(NSArray*)options withSelectedRow:(NSInteger)row {
    self.pickerController.choices = options;
    NSLog(@"Selecting %ld",(long)row);
    [self.pickerController selectRow:(int)row inComponent:0 animated:YES];
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
