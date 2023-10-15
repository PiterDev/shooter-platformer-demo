extends CharacterBody2D
class_name Player
# The player character

@export var speed = 300.0
@export var jump_velocity = -1000.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity: float = 2300.0
@export var max_fall_speed: float = 1500.0
@export var max_upward_speed: float = 1800.0

@export var jump_ended_early_gravity_modifier: float = 1.8

@export var apex_gravity_modifier: float = 0.8
@export var apex_speed_modifier: float = 1.2
var apex_over: bool = false

var jump_ended_early: bool = false
var shot_in_air: bool = false

@export var jump_buffer: int = 100
var jump_queued: bool = false
var buffer_queue_time: int = Time.get_ticks_msec()

var grounded_last_frame: bool = true
var time_left_grounded: int = -1
@export var coyote_treshold: int = 100

@export var ledge_push_strength: int = 8

@onready var speech: Label = $SpeechBubble

var can_boost_gravity_fall: bool = false

#var debug_last_jump_pos: Vector2

var airborne: bool = false
var speaking: bool = false

var last_checkpoint_pos: Vector2

var speech_queue: Array[String] = []

signal jump
signal dead

func _ready() -> void:
	last_checkpoint_pos = global_position

func _physics_process(delta: float) -> void:
	
	var gravity_to_apply: float = gravity
	var speed_to_apply: float = speed

	if grounded_last_frame && !is_on_floor():
		time_left_grounded = Time.get_ticks_msec()
	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		#debug_last_jump_pos = global_position + Vector2(0, 28)
		
		#$JumpIndicatorwwwwhow()
		if is_on_floor() || time_left_grounded + coyote_treshold >= Time.get_ticks_msec() and not airborne:
			Sounds.play_sound("jump", -25.0)
			jump.emit()
			velocity.y = jump_velocity
			jump_ended_early = false
			shot_in_air = false
		else:
			jump_queued = true
			buffer_queue_time = Time.get_ticks_msec()

	if Input.is_action_just_released("jump") && !jump_ended_early && velocity.y < 0 && !shot_in_air:
		jump_ended_early = true
		print("ended early")
	if is_on_floor():
		airborne = false
		can_boost_gravity_fall = true
		if jump_queued:
			if buffer_queue_time + jump_buffer >= Time.get_ticks_msec():
				jump.emit()
				velocity.y = jump_velocity
				jump_ended_early = false
				Sounds.play_sound("jump", -25.0)

		jump_queued = false
		jump_ended_early = false

	if jump_ended_early && !is_on_floor():
		gravity_to_apply *= jump_ended_early_gravity_modifier
	
	if velocity.y < 100.0 && velocity.y > -100.0 && !is_on_floor():
		speed_to_apply *= apex_speed_modifier
		gravity_to_apply *= apex_gravity_modifier
		can_boost_gravity_fall = true
	else:
		if can_boost_gravity_fall:
			gravity_to_apply *= jump_ended_early_gravity_modifier
		


	# Add the gravity.
	if not is_on_floor() || velocity.y < 0.0:
		velocity.y += gravity_to_apply * delta
	
	velocity.y = clamp(velocity.y, -max_upward_speed, max_fall_speed)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		if !airborne:
			velocity.x = direction * speed_to_apply
	elif !airborne:
		velocity.x = move_toward(velocity.x, 0, speed)
	grounded_last_frame = is_on_floor()

	if is_on_wall():
		velocity.y -= ledge_push_strength
		velocity.x += get_wall_normal().x * ledge_push_strength
	# if is_on_ceiling():
	# 	velocity.y -= 6.0
		
	# 	velocity.x += velocity.normalized().x * 6.0

	move_and_slide()

	if not speaking and speech_queue.size() > 0:
		speech.say(speech_queue[0])
		speech_queue.remove_at(0)
	#$JumpIndicator.global_position = debug_last_jump_pos

func say(text: String) -> void:
	speech_queue.push_back(text)

func die() -> void:
	Sounds.play_sound("die", -25.0)
	global_position = last_checkpoint_pos
	dead.emit()


func _on_gun_shoot() -> void:
	if is_on_floor():
		shot_in_air = true
