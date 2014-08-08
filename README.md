# UNDER CONSTRUCTION! Nothing to see here Yet...



# org.apache.cordova.picker
This plugin allows for more dynamic access to the picker widget normally displayed when a &lt;select&gt; is tapped, in particular on ios.
```sh
cordova plugin add https://github.com/mzbyszynski/cordova-plugin-picker.git
```
## Why
The &lt;select&gt; element when selected on ios is rendering as a PickerView scroll wheel. But the HTML element is difficult to control and programatically show, hide or refresh in mobile Safari/Cordova ios platform. It also does not support callbacks 
as the user interacts with the PickerView. This plugin allows direct control of the PickerView and what options are shown. This enables lazy-loading display options, dynamically changing options and paging large data sets.

This project borrows heavily from https://github.com/mgcrea/cordova-pickerview and its forks, but has been updated to work with Cordova 3.5.x and match the &lt;select&gt; picker display in ios 7.1. The plugin also differs from cordova-pickerview in two significant ways:

  1. It displays the PickerView by assigning First Responder to a hiddent field rather than using an Action Sheet, per   http://stackoverflow.com/questions/1262574/add-uipickerview-a-button-in-action-sheet-how.
  2. The JavaScript API is designed to be backed by an HTML select element.

## Roadmap
* 1.0:
  1. Full Documentation.
  2. Optional Next/Previous buttons with callbacks.

# Supported Platforms
- ios

# navigator.picker.create
Returns a `Picker` instance that manages a list of options and an optional series of callbacks associated with various picker events.
```JavaScript
var picker = navigator.picker.create();
```

# Picker
Analagous to a &lt;select&gt; element instance, this object allows you to set `Option`s, show and hide the picker and register callbacks to various events.
```JavaScript
  var mySelect = document.getElementById('myselect');
  var picker = navigator.picker.create();
  picker.options = mySelect.options;
  picker.onShow = function() {...  };
  picker.onClose = function(newVal, oldVal, theOptions) {... };
  picker.onSelect = function(newVal, oldVal, theOptions) {... };
  picker.show();
  picker.hide();
```

## Properties
- __options__: The `options` collection from an HTML `select` object. [See w3schools for more details](http://www.w3schools.com/jsref/coll_select_options.asp).

## Methods
- __show__: Shows the picker or refreshes the options if it is already shown. Invokes the onClose callback defined on this picker once the Picker is visible.
- __hide__: Hides the picker if it is visible.
- __update__: Updates the list of options displayed on the picker. 
  
  _Parameters:_
  - __newOptions__: (Optional) a new Select options collection that will overwrite the current value defined by the `options` propety. If this parameter is not provided then the picker is refreshed based on the current state of this Picker's `options` property.

## Callbacks

- __onShow__: `function` that, if defined, will be called after the picker is shown.
- __onClose__: `function` that, if defined, will be called when the when the picker is closed. 
  _Parameters:_
  1. Newly selected `Option` DOM element.
  2. Previously selected `Option` value (or `undefined` if there was no option previously selected).
  3. The select `options` collection.
- __onSelect__: `function` that, if defined, will be called when the user changes the option in focus in the picker. This event will be called as the user scrolls through the picker whenever the scroll wheel comes to a stop. It does not indicate that the user has chosen a selection.  
  _Parameters:_
  1. Newly focused `Option` DOM element.
  2. The currently selected `Option` value that was set prior to the picker being shown (or `undefined` if there was no option previously selected).
  3. The select `options` collection.
- __onOptionsChange__:
