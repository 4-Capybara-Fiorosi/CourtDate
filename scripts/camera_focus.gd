@tool
extends Area2D

@export var width_in_tiles :int = 1;
var _width_in_tiles := width_in_tiles;
@export var height_in_tiles :int = 1;
var _height_in_tiles := height_in_tiles;


func _update_width() -> void:
	if width_in_tiles != _width_in_tiles:
		_width_in_tiles = width_in_tiles;
		var width_in_px := _width_in_tiles * 16;
		$Shape.shape.size.x = width_in_px


func _update_height() -> void:
	if height_in_tiles != _height_in_tiles:
		_height_in_tiles = height_in_tiles;
		var height_in_px := _height_in_tiles * 16;
		$Shape.shape.size.y = height_in_px



func _process(_delta: float) -> void:
	_update_width()
	_update_height()


func _on_body_entered(body):
	if body is PlayerCharacter:
		var top = self.position.y - $Shape.shape.size.y / 2
		var bot = self.position.y + $Shape.shape.size.y / 2
		var left = self.position.x - $Shape.shape.size.x / 2
		var right = self.position.x + $Shape.shape.size.x / 2 
		(body as PlayerCharacter).focus_camera(top, right, bot, left)
