extends AnimatableBody2D

@export var jump_pad_strength: float = 1200.0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print(rotation)
		var velocity_to_apply: Vector2 = Vector2.UP.rotated(rotation) * jump_pad_strength
		#var velocity_to_apply: Vector2 = global_position.direction_to(body.global_position) * jump_pad_strength
		body.velocity = velocity_to_apply
		if "airborne" in body:
			print("Airborne")
			body.airborne = true
		# if !is_zero_approx(velocity_to_apply.x):
		# 	body.velocity.x += velocity_to_apply.x
		# 	print(body.velocity.x)
		# if !is_zero_approx(velocity_to_apply.y):
		# 	#body.velocity.y = velocity_to_apply.y
		# 	pass
