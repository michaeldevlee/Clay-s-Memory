extends Node2D

var shape_list = {}

func _ready():
	yield(owner, "ready")

func register_shapes():
	var shapes = get_children()
	if shapes:
		for x in shapes:
			var shape = shape_list[x]
			shape_list[x] = "UNOCCUPIED"
