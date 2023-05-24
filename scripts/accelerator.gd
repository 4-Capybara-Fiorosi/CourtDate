extends Area2D


## Jump Height in pixels
@export var jump_height :float = 112;
## Time from ground to the peak of the jump parabola in seconds
@export var jump_time_to_peak :float = 0.5;
@onready var jump_velocity :float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0;


func _on_body_entered(body):
	if not body is PlayerCharacter:
		return
	
	var player := body as PlayerCharacter;
	player.velocity.y = self.jump_velocity;
	
	var sfx_player :SFXDynamicPlayer = get_tree().root.get_child(0).get_node("SFXPlayer")
	sfx_player.play_dynamic("res://res/music/accel.mp3", 1.0)
	deactivate();
	$RespawnTimer.start(3);


func deactivate():
	self.set_visible(false);
	self.set_collision_mask_value(2, false)


func activate():
	self.set_visible(true);
	self.set_collision_mask_value(2, true)


func _on_respawn_timer_timeout():
	activate()
