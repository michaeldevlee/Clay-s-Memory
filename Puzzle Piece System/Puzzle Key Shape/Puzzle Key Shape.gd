extends Node2D

var shape_list = {}
var value_list = []

signal all_keys_assembled

func _ready():
	yield(owner, "ready")
	register_shapes()

func register_shapes():
	var shapes = get_children()
	if shapes:
		for x in shapes.size():
			var shape = shapes[x]
			shape_list[shape] = false
			shape.connect("shape_updated", self, "check_key_status")

func check_key_status(key_section : Key_Section, shape_status : bool):
	
	if key_section:
		shape_list[key_section] = shape_status
		
	value_list = shape_list.values()
	
	print(value_list)
	
	if value_list.has(false):
		print("not done")
		return
	
	emit_signal("all_keys_assembled")
	print("key opened!")
	
	
