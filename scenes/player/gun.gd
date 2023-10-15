extends Sprite2D
class_name Gun

@onready var player: CharacterBody2D = $"../.."
@onready var hand: Node2D = $".."
@onready var muzzle: Marker2D = $Muzzle
@onready var anim_player: AnimationPlayer = $AnimationPlayer
var bullet_scene: PackedScene = preload("res://scenes/bullet/bullet.tscn")


@export var recoil_strength: float = 800.0
const MAG_SIZE: int = 3

var ammo: int = MAG_SIZE


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		_shoot(true)
	if event.is_action_pressed("reload"):
		if ammo == MAG_SIZE:
			_reload()

func _shoot(auto_reload: bool) -> void:
	if ammo > 0:
		var direction_to_shoot: Vector2 = global_position.direction_to(get_global_mouse_position()) * -1
		var force_to_apply: Vector2 = direction_to_shoot * recoil_strength
		player.velocity = clamp(player.velocity+force_to_apply, force_to_apply, Vector2.INF)
		ammo -= 1
		spawn_bullet()
		anim_player.play("shoot")
		Sounds.play_sound("shoot", -20.0)
	elif auto_reload:
		_reload()


func _reload() -> void:
	if $ReloadTimer.is_stopped():
		$ReloadTimer.start()
		anim_player.play("reload")

func spawn_bullet() -> void:
	var new_bullet = bullet_scene.instantiate()
	player.owner.add_child(new_bullet)
	new_bullet.global_transform = muzzle.global_transform
	new_bullet.global_rotation_degrees = hand.global_rotation_degrees



func _on_reload_timer_timeout() -> void:
	anim_player.stop()
	ammo = MAG_SIZE
