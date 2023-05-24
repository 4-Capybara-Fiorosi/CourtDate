extends AudioStreamPlayer2D
class_name SFXDynamicPlayer


func load_mp3(path: String):
	var file := FileAccess.open(path, FileAccess.READ)
	var sound := AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	return sound


func play_dynamic(path_to_file: String, duration: float):
	if path_to_file == "":
		return;
	self.stream = load_mp3(path_to_file)
	self.play()
	get_tree().create_timer(duration).timeout.connect(func():
		self.stop())
