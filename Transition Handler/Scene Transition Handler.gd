extends Node2D

onready var anim_player = get_node("CanvasLayer/AnimationPlayer")

func fade_out():
	anim_player.play("Fade Out")

func fade_in():
	anim_player.play("Fade In")
