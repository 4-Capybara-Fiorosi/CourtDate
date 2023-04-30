class_name PlayerCharacter
extends CharacterBody2D

## The maximum movement speed of the player in px/s
@export var max_velocity :float = 200.0
## Acceleration in px/s^2
@export var acceleration :float = 25
## Decelaration in px/s^2 
@export var friction :float = 0.1
## Ladder climbing speed in px/s
@export var climb_speed :float = 10

## Jump Height in pixels
@export var jump_height :float = 32
## Time from ground to the peak of the jump parabola in seconds
@export var jump_time_to_peak :float = 0.5
## Time from the peak of the jump parabola to ground in seconds
@export var jump_time_to_descent :float = 0.4
## The time after leaving solid ground while the player can still jump
@export var coyote_time_seconds :float = 0.4
# The time before hitting solid ground while the player can queue a jump
@export var jump_queue_time :float = 0.2


@onready var jump_velocity :float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity :float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity :float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var can_climb :bool = false
var can_coyote_jump :bool = false
var is_jump_queued :bool = false

func _physics_process(delta :float):
	if is_on_floor():
		velocity.y = 0.0
		if is_jump_queued:
			is_jump_queued = false
			_jump()
	else:
		velocity.y += _get_gravity() * delta # TODO(AAL): clampf
	
	if is_on_floor() and can_coyote_jump == false:
		can_coyote_jump = true
	elif can_coyote_jump and $CoyoteTimeTimer.is_stopped():
		$CoyoteTimeTimer.start(coyote_time_seconds)
	
	var h_direction :float = _get_horizontal_movement_direction()
	if h_direction != 0:
		velocity.x = velocity.x + h_direction * acceleration
	else:
		velocity.x = lerpf(velocity.x, 0, friction)
	
	velocity.x = clampf(velocity.x, -max_velocity, max_velocity)
	velocity.x = 0.0 if is_equal_approx(velocity.x, 0) else velocity.x
	
	if Input.is_action_just_pressed("jump"):
		is_jump_queued = true
		$JumpQueueTimer.start(jump_queue_time)
		if can_coyote_jump:
			_jump()
	
	var v_direction :float = _get_vertical_movement_direciton()
	if v_direction != 0 and can_climb:
		velocity.y = v_direction * climb_speed
	
	
	move_and_slide()


func _get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity


func _jump():
	velocity.y = jump_velocity
	can_coyote_jump = false


func _get_horizontal_movement_direction() -> float:
	return Input.get_action_strength("move_right") - Input.get_action_strength("move_left")


func _get_vertical_movement_direciton() -> float:
	return Input.get_action_strength("move_down") - Input.get_action_strength("move_up")


func _on_ladder_enter(_body):
	can_climb = true

func die():
	print(Global.spawn_point)
	self.position = Global.spawn_point

func _ready():
	self.position = Global.spawn_point
	if is_instance_valid(self):
		add_to_group("Player")

func _on_ladder_exit(_body):
	can_climb = false


func _on_coyote_time_timer_timeout():
	can_coyote_jump = false


func _on_jump_queue_timer_timeout():
	is_jump_queued = false

