extends Area2D

@export var time_scale: float = 0.5

var player_inside: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_inside = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_inside = false

func _process(delta: float) -> void:
	if player_inside:
		Engine.time_scale = time_scale
	else:
		Engine.time_scale = 1.0
		
