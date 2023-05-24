extends Node


@export var speed: float = 0.5;
var direction: int = 1;
@export_node_path("PathFollow2D") var patrol_body_path: NodePath;
@onready var patrol_body : PathFollow2D = get_node(patrol_body_path);


func _ready():
	patrol_body.loop = false;


func _physics_process(delta: float):
	
	# if we're heading twards 1 and we hit it turn back
	if patrol_body.progress_ratio >= 1.0 && direction == 1:
		direction = -1;
	elif patrol_body.progress_ratio <= 0.0 && direction == -1:
		direction = 1;
	
	patrol_body.progress_ratio += delta * speed * direction;
	
	patrol_body.scale.x = direction
