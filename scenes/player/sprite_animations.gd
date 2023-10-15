extends Sprite2D

@onready var player_character: CharacterBody2D = $".."
@onready var player_sprite: Sprite2D = $"../Sprite"
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

func _process(_delta: float) -> void:
	if animation_player.current_animation == "jump":
		return
	if player_character.velocity.x > 0:
		player_sprite.flip_h = false
		animation_player.play("run_right")
	elif player_character.velocity.x < 0:
		player_sprite.flip_h = true
		animation_player.play("run_left")
	if player_character.velocity.x == 0.0:
		animation_player.play("idle")


func _on_player_jump() -> void:
	animation_player.stop()
	animation_player.play("jump")
