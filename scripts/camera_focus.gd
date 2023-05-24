@tool
extends Area2D

@export var width_in_tiles = 1 :
	set(new_width):
		width_in_tiles = new_width;
		var width_in_px :int = width_in_tiles * 16;
		$DefaultShape.shape.size.x = width_in_px;
@export var height_in_tiles = 1 :
	set(new_height):
		height_in_tiles = new_height;
		var height_in_px :int = height_in_tiles * 16;
		$DefaultShape.shape.size.y = height_in_px;

@export var dynamic_zoom = true : 
	set(new_val):
		dynamic_zoom = new_val;
		notify_property_list_changed();
var static_zoom := Vector2(1,1);


func _get_property_list():
	var property_usage = PROPERTY_USAGE_NO_EDITOR
	if not self.dynamic_zoom:
		property_usage = PROPERTY_USAGE_DEFAULT
	else:
		return []

	var properties = []
	
	properties.append({
		"name": "static_zoom",
		"type": TYPE_VECTOR2,
		"usage": property_usage, # See above assignment.
	})
	
	return properties


func _on_body_entered(body):
	if not body is PlayerCharacter:
		return;
	var player_body := body as PlayerCharacter; 
	
	var bounding_box :Rect2 = $DefaultShape.shape.get_rect()
	
	var top = self.position.y - bounding_box.size.y / 2;
	var bot = self.position.y + bounding_box.size.y / 2;
	var left = self.position.x - bounding_box.size.x / 2;
	var right = self.position.x + bounding_box.size.x / 2;
	
	var zoom := static_zoom
	if(dynamic_zoom):
		const window_size := Vector2(320, 320);
		var zoom_x :float = abs(left - right) / window_size.x;
		var zoom_y :float = abs(top - bot) / window_size.y;
		var zoom_1 = 1 / min(zoom_x, zoom_y);
		zoom = Vector2(zoom_1, zoom_1)
	player_body.focus_camera(top, right, bot, left, zoom);
