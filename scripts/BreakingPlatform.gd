extends Area2D


func _on_body_entered(body):
	if not body is PlayerCharacter:
		return
	$AnimationPlayer.play("destroyed")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "destroyed":
		self.set_visible(false);
		$CollShapeOne.disabled = true
		$StaticBody2D/CollShapeTwo.disabled = true
		$AnimationPlayer.play("idle")
		$RespawnTimer.start(2);
		


func _on_respawn_timer_timeout():
	self.set_visible(true);
	$CollShapeOne.disabled = false
	$StaticBody2D/CollShapeTwo.disabled = false
