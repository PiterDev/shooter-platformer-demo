extends AnimatableBody2D

@export var anim_player: AnimationPlayer

func _ready() -> void:
    if anim_player && !anim_player.is_playing():
        anim_player.play()