extends AnimatedSprite2D

@onready var gun: Node2D = $".."

func _ready() -> void:
	hide()

# func _process(_delta: float) -> void:
# 	rotation_degrees = 0
# 	position = gun.global_position + Vector2(0, -10)

func start_load() -> void:
	play("load")
	show()

func stop_load() -> void:
	stop()
	hide()
