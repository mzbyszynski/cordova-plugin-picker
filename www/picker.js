var CDVPicker = (function() {

  function Picker() {
    this._options = [];
  }

  Picker.prototype = {
    get options() {
      return (this._options || []);
    },
    set options(newOptions) {
      //TODO: UPDATE VIEW
      this._options = newOptions || [];
    },
    show: function() {
      console.log("showing picker");
      var scope = this;
      var win = function(result) {
        console.log("win returned " + result.event + " with row " + result.row + " and component " + result.component);
        if (result.event === "close" || result.event === "select") {
          var selected, oldValue;
          for (var i = 0; i < scope._options.length; i++) {
            if (i === result.row) {
              selected = scope._options[i];
              selected.selected = true;
            } else if (scope._options[i].selected) {
              oldValue = scope._options[i];
              oldValue.selected = false;
            }
          }
          if (result.event === "close" && typeof scope.onClose == 'function') 
            scope.onClose(selected, oldValue);
          else if (result.event === "select" && typeof scope.onSelect == 'function')
            scope.onSelect(selected, oldValue);
        } else if (result.event === "show" && typeof scope.onShow == 'function') {
          scope.onShow();
        } else if (result.event === "error" && typeof scope.onError == 'function') {
          scope.onError(result.error);
        }
      };
      cordova.exec(win, this.onError, "CDVPicker", "show", [(scope._options || [])]);
    }
  };

  console.log("Constructing CDVPicker");
  return {
    echo: function(msg, success, failure) {
      console.log("Invoking CDVPicker.echo");
      cordova.exec(success, failure, "CDVPicker", "echo", [msg]);
    },
    create: function() {
      return new Picker();
    }
  }
})();

console.log("don'e loading picker.js");