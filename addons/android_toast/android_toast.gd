extends Node


func make_toast(text : String, duration: int = -1) -> void:
	var android_runtime = Engine.get_singleton("AndroidRuntime")
	
	if android_runtime:
		# Retrieve the Android Activity instance.
		var activity = android_runtime.getActivity()
		# Create a Godot Callable to wrap the toast display logic.
		var toast_callable = func():
			# Use JavaClassWrapper to retrieve the android.widget.Toast class, then make and show a toast using the class APIs.
			var ToastClass = JavaClassWrapper.wrap("android.widget.Toast")
			ToastClass.makeText(activity, text, ToastClass.LENGTH_LONG if duration < 0 else duration).show()
		
		# Wrap the Callable in a Java Runnable and run it on the Android UI thread to show the toast.
		activity.runOnUiThread(android_runtime.createRunnableFromGodotCallable(toast_callable))
