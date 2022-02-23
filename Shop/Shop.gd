extends Node2D

onready var shop_UI = get_node("Shop UI/MarginContainer")

var is_shop_open : bool = false

func _on_Clickable_Area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			open_shop()

func open_shop():
	if !is_shop_open:
		is_shop_open = true
		shop_UI.visible = true
		ShopEvents.emit_signal("shop_opened")

func close_shop():
	shop_UI.visible = false
	is_shop_open = false
	ShopEvents.emit_signal("shop_closed")

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if is_shop_open:
			close_shop()

func _on_Exit_Button_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			close_shop()
