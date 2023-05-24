class_name DialogBox
extends TextureRect

@export var dialog_dict :Dictionary;
@export var textSpeed := 0.05;
@export var keyString :String;

@export var on_dialog_finished : Script = null; 

var dialog: Array;

var phraseNum :int = 0;
var finished := false;

func _ready():
	$Timer.wait_time = textSpeed
	dialog = dialog_dict[keyString]
	assert(dialog, "Dialog not found")
	nextPhrase()

var isKeyPressed = false 
func _input(event):
	$Indicator.visible = finished
	$Indicator/AnimationPlayer.play("DialogAnimation")
	if event is InputEventKey and event.keycode == KEY_E:
		if event.pressed and finished and not isKeyPressed:
			nextPhrase()
		elif not event.is_pressed():
			isKeyPressed = false
		else:
			$Text.visible_characters = len($Text.text)
			isKeyPressed = true


func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		get_parent().queue_free()
		(get_parent() as DialogSupervisor).dialog_finished.emit(on_dialog_finished)
		return
	finished = false
	isKeyPressed = true
	
	var text := "[center] %s [/center]" % [dialog[phraseNum]["Name"]]
	$Name.bbcode_text = text
	$Text.bbcode_text = dialog[phraseNum]["Text"]
	$Sprite2D.texture = load(dialog[phraseNum]["Action"])
	$Text.visible_characters = 0
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		
		$Timer.start()
		await $Timer.timeout
	finished = true
	phraseNum += 1
	return
