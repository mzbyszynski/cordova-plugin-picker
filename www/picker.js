module.exports = (function() {

  function Picker() {
    this._options = [];
  }

  var win = function(result) {
    console.log("win returned " + result.event + " with row " + result.row + " and component " + result.component);
    if (result.event === "close" || result.event === "select") {
      //TODO: if this is done on select, does it need to be done on close as well? Select should have already been fired?
      var selected, oldValue;
      for (var i = 0; i < this._options.length; i++) {
        if (i === result.row) {
          selected = this._options[i];
          selected.selected = true;
        } else if (this._options[i].selected) {
          oldValue = this._options[i];
          oldValue.selected = false;
        }
      }
      if (result.event === "close" && typeof this.onClose == 'function') 
        this.onClose(selected, oldValue);
      else if (result.event === "select" && typeof this.onSelect == 'function') 
        this.onSelect(selected, oldValue);
    } else if (result.event === "show" && typeof this.onShow == 'function')
      this.onShow();
    else if (result.event === "change" && typeof this.onOptionsChange == 'function')
      this.onOptionsChange(this._options);
    else if (result.event === "error" && typeof this.onError == 'function') 
      this.onError(result.error);
  };

  Picker.prototype = {
    get options() {
      return (this._options || []);
    },
    set options(newOptions) {
      this.update(newOptions || []);
    },
    show: function() {
      console.log("showing picker");
      cordova.exec(win.bind(this), this.onError, "Picker", "show", [(this._options || [])]);
    },
    hide: function() {
      cordova.exec(win.bind(this), this.onError, "Picker", "hide", []);
    },
    update: function(newOptions) {
      this._options = newOptions;
      cordova.exec(win.bind(this), this.onError, "Picker", "updateOptions", [(this._options || [])]);
    }
  };

  console.log("Constructing CDVPicker");
  return {
    echo: function(msg, success, failure) {
      console.log("Invoking CDVPicker.echo");
      cordova.exec(success, failure, "Picker", "echo", [msg]);
    },
    create: function() {
      return new Picker();
    }
  }
})();