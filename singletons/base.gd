extends Node

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen"):
		var mode: DisplayServer.WindowMode = DisplayServer.window_get_mode()
		if mode == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)      
		
