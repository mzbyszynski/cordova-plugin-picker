# org.apache.cordova.picker
This plugin allows for more dynamic access to the picker widget normally displayed when a &lt;select&gt; is tapped, in particular on ios.
```sh
cordova plugin add https://github.com/mzbyszynski/cordova-plugin-picker.git
```
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

## Methdods
- __show__:
- __hide__:

## Callbacks

- __onShow__: 
- __onClose__:
- __onSelect__:
