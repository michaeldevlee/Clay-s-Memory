extends Node2D
class_name Weight_Button_Key

signal all_buttons_pressed

var button_list = {}
var button_list_values

func _ready():
	var buttons = get_children()
	
	if buttons:
		for x in buttons.size():
			var button = buttons[x]
			button.connect("button_status_changed", self, "update_button_status")
			button_list[button] = false

func update_button_status(button : Weight_Button, pressed : bool):
	
	print(button)
	if button and button_list:
		button_list[button] = pressed
	
	button_list_values = button_list.values()
	
	if button_list_values.has(false):
		print("not done yet")
		return
	
	print("finished all keys")
	emit_signal("all_buttons_pressed")
