extends CharacterBody2D
class_name Bullet

@onready var delete_timer: Timer = $DeleteTimer

@export var speed: int = 900

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Vector2.RIGHT.rotated(rotation)
	velocity = direction * speed
	var collision_info: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision_info:
		var collider: Object = collision_info.get_collider()
		if collider is TileMap or collider is StaticBody2D:
			hide()
			speed = 0
			delete_timer.start() # Let all the collisions happen, then remove


func _on_delete_timer_timeout() -> void:
	queue_free()
