extends Node2D

@export var enabled: bool = true

@onready var collision_shape: CollisionShape2D = $StaticBody2D/CollisionShape2D

func _ready() -> void:
	update_visibility()

func toggle() -> void:
	enabled = not enabled
	Sounds.play_sound("toggle", -30.0)
	update_visibility()

func update_visibility():
	if enabled:
		collision_shape.set_deferred("disabled", false)
		show()
	else:
		collision_shape.set_deferred("disabled", true)
		hide()
