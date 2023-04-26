class_name Door
extends StaticBody2D

func _ready():
	$AnimatedSprite2D.position.x = 0;
	$AnimatedSprite2D.play("closed");
	collision_layer = 0b1;

func open():
	$AnimatedSprite2D.position.x = 5;
	$AnimatedSprite2D.play("open");
	collision_layer = 0;

func close():
	$AnimatedSprite2D.position.x = 0;
	$AnimatedSprite2D.play("closed");
	collision_layer = 0b1;
