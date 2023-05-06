extends Area2D


func _on_body_entered(body):
	if not body is PlayerCharacter:
		return
	$AnimationPlayer.play("destroyed")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "destroyed":
		get_parent().queue_free()
