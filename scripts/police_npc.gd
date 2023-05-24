extends Node2D

@export var hasFrontalDirection := true
@export var awaitTime := 1
var seesLeft := true
var leftSuit = preload("res://dialogues/Police/police_left.png")
var rightSuit = preload("res://dialogues/Police/police_normal.png")

func _ready():
	if hasFrontalDirection == true:
		return
	while true:
		if seesLeft == true:
			$skin.texture = leftSuit
		else:
			$skin.texture = rightSuit
			
		$LeftPoly.visible = seesLeft
		$RightPoly.visible = !seesLeft
		seesLeft = !seesLeft
		await get_tree().create_timer(awaitTime).timeout
