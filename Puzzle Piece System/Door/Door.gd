extends Node2D

export var key_path : NodePath
var key

func _ready():
	if key_path:
		key = get_node(key_path)
		key.connect("all_keys_assembled", self, "open_door")

func open_door():
	queue_free()
