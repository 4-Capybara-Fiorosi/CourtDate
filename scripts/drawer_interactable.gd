extends Interactable

@export var bedroom_door: NodePath
@onready var door : Door = get_node(bedroom_door)

var suit = preload("res://res/animations/player_suit.tres")
var pijamas = preload("res://res/animations/player_pijamas.tres")

func interact(player: PlayerCharacter):
	if player.is_in_pijamas:
		player.skin.sprite_frames = suit;
		player.is_in_pijamas = false
		door.open()
	else:
		player.skin.sprite_frames = pijamas
		player.is_in_pijamas = true
		door.close()
	var sfx_player :SFXDynamicPlayer = get_tree().root.get_child(0).get_node("SFXPlayer")
	sfx_player.play_dynamic("res://res/music/dress.mp3", 1.0)
