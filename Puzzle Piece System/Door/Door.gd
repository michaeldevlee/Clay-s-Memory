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
		
		if key is Reflection_Receiver_Key:
			key.connect("all_receivers_shined", self, "open_door")
			print("open receiever door")
			
func open_door():
	queue_free()
