extends Interactable


func interact(player: PlayerCharacter):
	player.last_checkpoint_position = self.position
