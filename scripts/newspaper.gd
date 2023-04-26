extends Interactable

@onready var cutscene :PackedScene = preload("res://scenes/DialogBox.tscn")
@onready var player_script :Script = preload("res://scripts/player.gd")



func interact(player : PlayerCharacter):
	player.pause()
	var supervisor :DialogSupervisor = cutscene.instantiate()
	supervisor.dialog_finished.connect(player.unpause)
	player.add_child(supervisor)
	queue_free()
