extends Line2D

@onready var player: CharacterBody2D = $".."
var max_points: int = 30

func _ready() -> void:
	set_as_top_level(true)
	clear_points()

func _process(_delta: float) -> void:
	#global_position = Vector2(0,0)
	add_point(player.global_position)
	if points.size() > max_points:
		remove_point(0)
