extends TextureRect

@export var dialogPath = ""
@export var textSpeed = 0.05
@export var keyString = ""

var dialog 

var phraseNum = 0
var finished = false

func _ready():
	$Timer.wait_time = textSpeed
	dialog = getDialog()
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

func getDialog() -> Array:
	var file = FileAccess.open(dialogPath, FileAccess.READ)
	var content = file.get_as_text()
	var output = JSON.parse_string(content)
	if keyString.is_empty():
		return []
	output = output[keyString]
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
		
func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		queue_free()
		return
	finished = false
	isKeyPressed = true
	
	$Name.bbcode_text = dialog[phraseNum]["Name"]
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
		
