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


@onready var jump_velocity :float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity :float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity :float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var can_climb :bool = false


func _physics_process(delta :float):
	velocity.y += _get_gravity() * delta
	
	var h_direction :float = _get_horizontal_movement_direction()
	if h_direction != 0:
		velocity.x = velocity.x + h_direction * acceleration
	else:
		velocity.x = lerpf(velocity.x, 0, friction)
	
	velocity.x = clampf(velocity.x, -max_velocity, max_velocity)
	velocity.x = 0.0 if is_equal_approx(velocity.x, 0) else velocity.x
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		_jump()
	
	var v_direction :float = _get_vertical_movement_direciton()
	if v_direction != 0 and can_climb:
		velocity.y = v_direction * climb_speed
	
	
	move_and_slide()


func _get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func _jump():
	velocity.y = jump_velocity

func _get_horizontal_movement_direction() -> float:
	return Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

func _get_vertical_movement_direciton() -> float:
	return Input.get_action_strength("move_down") - Input.get_action_strength("move_up")


func _on_ladder_enter(_body):
	can_climb = true


func _on_ladder_exit(_body):
	can_climb = false
