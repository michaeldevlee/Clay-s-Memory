extends Sprite

var key_shape
var key_complete : bool = false
var distance_to_shape
var detection_status : bool = false
var piece_to_detect

func _ready():
	if texture:
		key_shape = PieceEvents.shapes[texture]

func detecting_shape():
	if detection_status == true and piece_to_detect is Puzzle_Piece:
		var rigid_body = piece_to_detect.rigid_body
		distance_to_shape = rigid_body.global_position.distance_to(global_position)

func check_shape():
	if distance_to_shape <= 20:
		if key_shape == PieceEvents.shapes[piece_to_detect.sprite.texture]:
			if piece_to_detect.picked_up == true:
				print("correct shape")

		
	

func _input(event):
	if detection_status == true and event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			check_shape()
				


func _on_Detection_Area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.name == "Grab Area" and piece_to_detect == null and area.owner is Puzzle_Piece:
		piece_to_detect = area.owner
		if piece_to_detect.piece_type == "PUZZLE_PIECE":
			print(piece_to_detect)
			piece_to_detect = area.owner
			detection_status = true
			print("detecting")
		else:
			piece_to_detect = null
			
func _on_Detection_Area_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if area.name == "Grab Area" and piece_to_detect and piece_to_detect is Puzzle_Piece:
		if piece_to_detect.piece_type == "PUZZLE_PIECE":
			piece_to_detect = null
			detection_status = false
			print("not detecting")

func _physics_process(delta):
	detecting_shape()
