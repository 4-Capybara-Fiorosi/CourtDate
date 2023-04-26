extends Interactable

@export var door_to_open: NodePath
@onready var door: Door = get_node(door_to_open)

func interact(_player: PlayerCharacter):
	door.open()
	self.queue_free()
