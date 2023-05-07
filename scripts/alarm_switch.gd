extends Interactable

@export var door_to_open: NodePath

var closedSwitch = preload("res://res/tiles/LVL3/alarn_switch_closed.png")
var openedSwitch = preload("res://res/tiles/LVL3/alarm_switch_opened.png")

@onready var door: Door = get_node(door_to_open)

func interact(_player: PlayerCharacter):
	door.open()
	$AlarmSwitch.texture = closedSwitch
	$AlarmSwitchShape.visible = false
