Elm.Native.DatePicker = {};
Elm.Native.DatePicker.make = function(localRuntime) {

	localRuntime.Native = localRuntime.Native || {};
	localRuntime.Native.DatePicker = localRuntime.Native.DatePicker || {};
	if (localRuntime.Native.DatePicker.values)
	{
		return localRuntime.Native.DatePicker.values;
	}

	var Task = Elm.Native.Task.make(localRuntime);
	var Utils = Elm.Native.Utils.make(localRuntime);


	var getCurrentTime = Task.asyncFunction(function(callback) {
		return callback(Task.succeed(Date.now()));
	});


	return localRuntime.Native.DatePicker.values = {
		getCurrentTime: getCurrentTime
	};
};