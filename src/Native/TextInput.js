Elm.Native.TextInput = {};
Elm.Native.TextInput.make = function make(localRuntime) {
  localRuntime.Native = localRuntime.Native || {};
  localRuntime.Native.TextInput = localRuntime.Native.TextInput || {};

  if (localRuntime.Native.TextInput.values) return localRuntime.Native.TextInput.values;

  var getHeight = function(defaultHeight){
    var field = document.getElementById('BelleTextInputMeasure');
    return field ? field.clientHeight+5 : defaultHeight;
  };

  return localRuntime.Native.TextInput.values = {
    getHeight: getHeight
  };
};
