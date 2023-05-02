@tool
class_name DialogInteractible
extends Interactable

@export_file("*.json") var dialog_json = "":
	set(new_value):
		dialog_json = new_value;
		if not dialog_json.is_empty():
			dialog_dict = JSON.parse_string(FileAccess.open(dialog_json, FileAccess.READ)
							.get_as_text()) as Dictionary;
		else:
			dialog_dict = {};
		notify_property_list_changed();

var dialog_dict :Dictionary;

var dialog_key :String;
@export var text_speed := 0.05;

@onready var dialog_manager_scene :PackedScene = preload("res://scenes/DialogBox.tscn");

func _get_property_list():
	var property_usage = PROPERTY_USAGE_NO_EDITOR
	if self.dialog_dict != null && not dialog_json.is_empty():
		property_usage = PROPERTY_USAGE_DEFAULT
	else:
		return []

	var properties = []
	
	var hint_string :String = dialog_dict.keys().reduce(
		func(accum, key: String):
			return accum + "," + key);
	
	properties.append({
		"name": "dialog_key",
		"type": TYPE_STRING,
		"usage": property_usage, # See above assignment.
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": hint_string
	})
	
	return properties


func interact(player: PlayerCharacter):
	player.pause()
	var dialog_supervisor :DialogSupervisor = dialog_manager_scene.instantiate();
	var box :DialogBox = dialog_supervisor.get_child(0);
	box.dialog_dict = dialog_dict;
	box.textSpeed = self.text_speed;
	box.keyString = self.dialog_key;
	dialog_supervisor.dialog_finished.connect(player.unpause)
	player.add_child(dialog_supervisor)
