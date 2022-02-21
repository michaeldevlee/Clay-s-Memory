extends Sprite
class_name Key_Section

var key_shape
var key_complete : bool = false
var distance_to_shape
var detection_status : bool = false
var piece_to_detect
var correct_shape_received : bool = false

signal shape_updated (key_section, shape_status)

func _ready():
	if texture:
		key_shape = PieceEvents.shapes[texture]

func detecting_shape():
	if detection_status == true and piece_to_detect is Puzzle_Piece:
		var rigid_body = piece_to_detect.rigid_body
		distance_to_shape = rigid_body.global_position.distance_to(global_position)

func check_shape():
	if distance_to_shape <= 40:
		if key_shape == PieceEvents.shapes[piece_to_detect.sprite.texture]:
			correct_shape_received = true
			print("correct shaped placed")	
	emit_signal("shape_updated", self, correct_shape_received)

func _input(event):
	if detection_status == true and event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			if PieceEvents.picked_up_piece:
				check_shape()
	
	if Input.is_action_just_pressed("ui_down"):
		print(correct_shape_received)
				
func _on_Detection_Area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.name == "Detect Area" and piece_to_detect == null and area.owner is Puzzle_Piece:
		piece_to_detect = area.owner
		if piece_to_detect.piece_type == "PUZZLE_PIECE":
			print(piece_to_detect)
			piece_to_detect = area.owner
			detection_status = true
		else:
			piece_to_detect = null
			
func _on_Detection_Area_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if area.name == "Detect Area" and piece_to_detect and piece_to_detect is Puzzle_Piece:
		if piece_to_detect.piece_type == "PUZZLE_PIECE":
			piece_to_detect = null
			detection_status = false
			correct_shape_received = false
			emit_signal("shape_updated", self, correct_shape_received)

func _physics_process(delta):
	detecting_shape()
