extends Area2D

@export_multiline var to_say: String
@export var run_multiple_times: bool = false
var already_started: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player and (run_multiple_times or not already_started):
		body.say(to_say)
		already_started = true
