@tool
extends Sprite2D

@export var leftLightLength = 16 :
	set(new_value):
		leftLightLength = new_value
		$LeftLight.polygon[0].x = -leftLightLength
		$LeftLight.polygon[1].x = -leftLightLength
		$LeftLight.polygon[2].x = -leftLightLength

@export var rightLightLength = 16:
	set(new_value):
		rightLightLength = new_value
		$RightLight.polygon[5].x = rightLightLength
		$RightLight.polygon[4].x = rightLightLength
		$RightLight.polygon[3].x = rightLightLength
