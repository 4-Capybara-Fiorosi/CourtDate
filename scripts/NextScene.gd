extends Area2D

@export_file var next_scene;

func _on_body_entered(body):
	if not body is PlayerCharacter:
		return
	
	get_tree().change_scene_to_file(next_scene)
