extends Node2D
class_name Bullet

onready var sprite = get_node("Sprite")

func _on_Hit_Area_body_entered(body):
	if body is StaticBody2D:
		queue_free()

func update_player_direction(direction : int):
	sprite.player_direction = direction

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
