extends Node2D

export var go_to_area_path : NodePath
export var go_back_to_area_path : NodePath

var room_change_area_1
var room_change_area_2
var area_1
var area_2

func _ready():
	area_1 = get_node(go_to_area_path)
	area_2 = get_node(go_back_to_area_path)
	
	if area_1 and area_2:
		room_change_area_1 = area_1.collision_shape
		room_change_area_2 = area_2.collision_shape
		
		area_1.connect("body_entered", self, "_on_Room_Change_Area_body_entered")
		area_2.connect("body_entered", self, "_on_Room_Change_Area2_body_entered")
		
		room_change_area_2.set_deferred("disabled", true)
	

func _on_Room_Change_Area_body_entered(body):
	if room_change_area_1 == null || room_change_area_2 == null:
		if area_1 == null || area_2 == null:
			print(self, "areas are not loaded correctly")
			return
			
	if body.name == "Player":
		var direction = area_1.direction
		var direction_amt = area_1.direction_amt
		
		LevelManager.emit_signal("room_change_initiated", direction, direction_amt)
		room_change_area_1.set_deferred("disabled", true)
		room_change_area_2.set_deferred("disabled", false)

func _on_Room_Change_Area2_body_entered(body):
	if body.name == "Player":
		var direction = area_2.direction
		var direction_amt = area_2.direction_amt
		
		LevelManager.emit_signal("room_change_initiated", direction, direction_amt)
		room_change_area_1.set_deferred("disabled", false)
		room_change_area_2.set_deferred("disabled", true)
