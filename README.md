# org.apache.cordova.picker


This plugin allows for more dynamic access to the picker widget normally displayed when a &lt;select&gt; is tapped, in particular on ios.

```sh
cordova plugin add https://github.com/mzbyszynski/cordova-plugin-picker.git
```

# Supported Platforms
- ios

# navigator.picker.create

Returns a `Picker` instance that manages a list of options and an optional series of callbacks associated with various picker events.

```javascript
var picker = navigator.picker.create();
```

