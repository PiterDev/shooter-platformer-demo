extends Node2D

func _process(_delta: float) -> void:
	_rotate_hand()

func _rotate_hand() -> void:
	var object_v := get_global_mouse_position() - global_position 
	var angle := object_v.angle()
	#var object_rotation = global_rotation
	global_rotation = lerp_angle(global_rotation, angle, .5)
	
	if global_rotation_degrees > 100 || global_rotation_degrees < -100:
		scale.y = -1
	elif global_rotation_degrees < 100 || global_rotation_degrees > -100:
		scale.y = 1
