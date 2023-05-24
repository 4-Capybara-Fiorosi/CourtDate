extends CanvasLayer

@export var is_first_level := false;
@onready var bgm_player :AudioStreamPlayer2D = get_tree().root.get_child(0).get_node("MusicPlayer")

func _ready():
	(bgm_player.stream as AudioStreamMP3).loop = true;
	if is_first_level:
		get_tree().create_timer(0.1).timeout.connect(func():
			get_tree().paused = true;
		)
		$Start.visible = true;
	else:
		$Start.visible = false;
		bgm_player.play()
	$Pause.visible = false;


func _on_button_start_pressed():
	get_tree().paused = false;
	var sfx_player :SFXDynamicPlayer = get_tree().root.get_child(0).get_node("SFXPlayer")
	sfx_player.play_dynamic("res://res/music/alarm.mp3", 1.0)
	get_tree().create_timer(2.0).timeout.connect(func():
		bgm_player.play())
	$Start.visible = false;
	$Pause.visible = false;


func _on_button_continue_pressed():
	get_tree().paused = false;
	$Start.visible = false;
	$Pause.visible = false;


func _unhandled_input(event):
	if not event.is_action_pressed("open_menu"):
		return
	$Pause.visible = true;
	get_tree().paused = true;
