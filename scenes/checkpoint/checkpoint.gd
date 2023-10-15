extends Area2D

@export var off_color: Color
@export var on_color: Color

@onready var light: PointLight2D = $PointLight2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var on: bool = false

func _ready() -> void:
	update_visuals()

func update_visuals() -> void:
	if on:
		var tween: Tween = create_tween()
		tween.tween_property(light, "color", on_color, 0.2).set_ease(Tween.EASE_IN_OUT)
		tween.play()
		
		#light.color = on_color
		animation_player.play("enabled")
	else:
		var tween: Tween = create_tween()
		tween.tween_property(light, "color", off_color, 0.15).set_ease(Tween.EASE_IN_OUT)
		tween.play()
		#light.color = off_color
		animation_player.stop()

func checkpoint_update() -> void:
	on = false
	update_visuals()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if !on:
			get_tree().call_group("Checkpoints", "checkpoint_update")
			Sounds.play_sound("battery", -30.0)
			on = true
			print(on)
			body.last_checkpoint_pos = global_position
		update_visuals()
