extends Interactable

@export var door_to_open: NodePath
@onready var door: Door = get_node(door_to_open)

func interact(_player: PlayerCharacter):
	door.open()
	self.queue_free()
	var sfx_player :SFXDynamicPlayer = get_tree().root.get_child(0).get_node("SFXPlayer")
	sfx_player.play_dynamic("res://res/music/door.mp3", 1.0)
