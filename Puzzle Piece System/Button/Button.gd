extends Node2D
class_name Weight_Button

onready var sprite = get_node("Sprite")

var pressed_pic = preload("res://Puzzle Piece System/Button/Button Pressed.png")
var unpressed_pic = preload("res://Puzzle Piece System/Button/Button.png")
var pressed : bool = false

signal button_status_changed(button, pressed)

func _on_Press_Area_body_entered(body):
	if body.owner is Puzzle_Piece and body.owner.piece_type == "DROPPABLE":
		sprite.texture = pressed_pic
		pressed = true
		emit_signal("button_status_changed", self, pressed)

func _on_Press_Area_body_exited(body):
	if body.owner is Puzzle_Piece and body.owner.piece_type == "DROPPABLE":
		sprite.texture = unpressed_pic
		pressed = false
		emit_signal("button_status_changed", self, pressed)
