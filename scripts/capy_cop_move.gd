extends Path2D

var inc=0
var speed=50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $PathFollow2D.progress_ratio == 1:
		$PathFollow2D.progress_ratio = 0
	else:
		$PathFollow2D.progress += delta * speed
