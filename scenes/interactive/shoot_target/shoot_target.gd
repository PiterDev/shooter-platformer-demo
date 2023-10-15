extends Node2D

@export var group_to_call: String
@export var method_to_call: String


func _on_area_2d_body_entered(body:Node2D) -> void:
	if body is Bullet:
		body.queue_free()
		if group_to_call != null and method_to_call != null:
			get_tree().call_group(group_to_call, method_to_call)
			body.queue_free()
