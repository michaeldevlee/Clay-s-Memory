extends Node2D
class_name Puzzle_Piece

export (String, "PUZZLE_PIECE", "REFLECTOR", "DROPPABLE", "PLATFORM") var piece_type = "PUZZLE_PIECE"

onready var rigid_body = get_node("RigidBody2D")
onready var rigid_body_collider = get_node("RigidBody2D/CollisionShape2D")
onready var throwing_area = get_node("RigidBody2D/Puzzle Piece/Throwing Area/CollisionShape2D")
onready var sprite = get_node("RigidBody2D/Puzzle Piece")
onready var symbol = get_node("RigidBody2D/Puzzle Piece/Symbol")

var picked_up : bool = false
var sprite_size 

func _ready():
	yield(owner,"ready")
	initialize_piece()
	sprite_size = sprite.texture.get_size()

func initialize_piece():
	match piece_type:
		"PUZZLE_PIECE":
			rigid_body.mode =RigidBody2D.MODE_KINEMATIC
			rigid_body_collider.disabled = true
			symbol.texture = PieceEvents.puzzle_piece_symbol
		"PLATFORM":
			rigid_body.mode =RigidBody2D.MODE_KINEMATIC
			rigid_body_collider.disabled = false
			symbol.texture = PieceEvents.platform_symbol
		"DROPPABLE":
			rigid_body.mode =RigidBody2D.MODE_RIGID
			rigid_body_collider.disabled = false
			symbol.texture = PieceEvents.weight_symbol
		"REFLECTOR":
			symbol.texture = PieceEvents.reflector_symbol

func _on_Grab_Area_input_event(viewport, event, shape_idx):
	process_puzzle_piece_input(event)
	
func process_puzzle_piece_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1 and !picked_up:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			rigid_body_collider.disabled = true
			picked_up = true
			throwing_area.disabled = false
			PieceEvents.emit_signal("pick_up_event_initiated", self, "PICK_UP")
			rigid_body.mode = RigidBody2D.MODE_KINEMATIC

func _on_Throwing_Area_input_event(viewport, event, shape_idx):
	
	var throw_speed : Vector2
	
	if event is InputEventMouseMotion:
		throw_speed = event.speed 
	
	
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1 and picked_up:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			rigid_body_collider.disabled = false
			picked_up = false
			throwing_area.disabled = true
			PieceEvents.emit_signal("pick_up_event_initiated", self, "DROP")
			
			initialize_piece()
			


func _physics_process(delta):
	if picked_up:
		rigid_body.global_position = lerp(rigid_body.global_position.round(), get_global_mouse_position().round(), 1)






