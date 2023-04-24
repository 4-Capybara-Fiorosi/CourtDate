extends Interactable


var suit = preload("res://res/animations/player_suit.tres")
var pijamas = preload("res://res/animations/player_pijamas.tres")

func interact(player: PlayerCharacter):
	if player.is_in_pijamas:
		player.skin.sprite_frames = suit;
		player.is_in_pijamas = false
	else:
		player.skin.sprite_frames = pijamas
		player.is_in_pijamas = true
