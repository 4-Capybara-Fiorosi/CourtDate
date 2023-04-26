class_name Interactable
extends Area2D

@export var active_color : Color = Color.YELLOW;
@export var skin_path : NodePath;
@onready var skin :Sprite2D = get_node(skin_path);

@onready var interactable_material :Material = preload("res://res/shaders/interactable_material.tres");

func _ready() -> void:
	skin.material = interactable_material.duplicate()
	skin.material.set("shader_parameter/outline_color", active_color);

func player_entered():
	skin.material.set("shader_parameter/width", 1);


func player_exit():
	skin.material.set("shader_parameter/width", 0);


func interact(_player: PlayerCharacter):
	pass
