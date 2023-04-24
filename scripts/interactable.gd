class_name Interactable
extends Area2D

@onready var skin := get_child(0)


func player_entered():
	(skin as Sprite2D).material.set("shader_parameter/width", 1)


func player_exit():
	(skin as Sprite2D).material.set("shader_parameter/width", 0)


func interact(player: PlayerCharacter):
	pass
