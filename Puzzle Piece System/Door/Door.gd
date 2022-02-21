extends Node2D

export var key_path : NodePath
var key

func _ready():
	if key_path:
		key = get_node(key_path)
		
		if key is Shape_Key:
			key.connect("all_keys_assembled", self, "open_door")
		
		if key is Weight_Button_Key:
			key.connect("all_buttons_pressed", self, "open_door")

func open_door():
	queue_free()
