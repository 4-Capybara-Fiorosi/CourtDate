@tool
class_name Door
extends StaticBody2D

@export_multiline var notification :String = ""
var is_closed :bool = true

func _ready():
	$AnimatedSprite2D.position.x = 0;
	$AnimatedSprite2D.play("closed");
	collision_layer = 0b1;
	$Notification/Panel/Label.text = notification;

func _process(_delta):
	if $Notification/Panel/Label.text != notification:
		$Notification/Panel/Label.text = notification
		print("notification changed")

func open():
	$AnimatedSprite2D.position.x = 5;
	$AnimatedSprite2D.play("open");
	collision_layer = 0;
	is_closed = false;

func close():
	$AnimatedSprite2D.position.x = 0;
	$AnimatedSprite2D.play("closed");
	collision_layer = 0b1;
	is_closed = true;


func _on_notify_area_body_entered(body):
	if not is_closed:
		return
	if not body is PlayerCharacter:
		return;
	body = body as PlayerCharacter;
	$Notification.set_visible(true)


func _on_notify_area_body_exited(body):
	if not is_closed:
		return
	if not body is PlayerCharacter:
		return;
	body = body as PlayerCharacter;
	$Notification.set_visible(false)
