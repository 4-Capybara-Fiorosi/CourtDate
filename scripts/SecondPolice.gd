extends Node2D

var isLeft :bool = false 
@export var interval_time: float = 2.0  # Time interval in seconds
# Called when the node enters the scene tree for the first time.
func _ready():
	while true:
		isLeft = !isLeft
		if isLeft == true:
			$FPLeftPoli2.visible = true
		else:
			$FPLeftPoli2.visible = false
		await ToSignal(get_tree().create_timer(interval_time), "timeout")
