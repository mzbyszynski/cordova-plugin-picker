# UNDER CONSTRUCTION! Nothing to see here Yet...



# org.apache.cordova.picker
This plugin allows for more dynamic access to the picker widget normally displayed when a &lt;select&gt; is tapped, in particular on ios.
```sh
cordova plugin add https://github.com/mzbyszynski/cordova-plugin-picker.git
```
## Why
The &lt;select&gt; element when selected on ios is rendering as a PickerView scroll wheel. But the HTML element is difficult to control and programatically show, hide or refresh in mobile Safari/Cordova ios platform. It also does not support callbacks 
as the user interacts with the PickerView. This plugin allows direct control of the PickerView and what options are shown. This enables lazy-loading display options, dynamically changing options and paging large data sets.

This project borrows heavily from https://github.com/mgcrea/cordova-pickerview and its forks, but has been updated to work with Cordova 3.5.x and match the &lt;select&gt; picker display in ios 7.1. The plugin also differs from cordova-pickerview in that it 
displays the PickerView by assigning First Responder to a hiddent field rather than using an Action Sheet, per http://stackoverflow.com/questions/1262574/add-uipickerview-a-button-in-action-sheet-how.

## Roadmap
* 1.0:
  1. Full Documentation.
  2. Optional Next/Previous buttons with callbacks.
  3. configuration options for option display text property.

# Supported Platforms
- ios

# navigator.picker.create
Returns a `Picker` instance that manages a list of options and an optional series of callbacks associated with various picker events.
```JavaScript
var picker = navigator.picker.create();
```

# Picker
Analagous to a &lt;select&gt; element instance, this object allows you to set `Option`s, show and hide the picker and register callbacks to various events.
```JavaScrpit
  picker.options = [{text: 'opt 1'}, 
                    {text: 'opt 2'},
                    {text: 'thee right choice', selected: true}, 
                    {text: 'opt 19'}];
  picker.onShow = function() {...  };
  picker.onClose = function(newVal, oldVal) {... };
  picker.onSelect = function(newVal, oldVal) {... };
  picker.show();
  picker.hide();
```

## Properties
- __options__:

## Methods
- __show__:
- __hide__:

## Callbacks

- __onShow__: 
- __onClose__:
- __onSelect__:
