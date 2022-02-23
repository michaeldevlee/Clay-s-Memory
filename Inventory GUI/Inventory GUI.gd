extends Control

onready var stash_button = get_node("Stash UI/MarginContainer/HBoxContainer/Stash")

var piece_inventory = {
	
}

func _ready():
	stash_button.connect("piece_stashed", self, "add_piece_to_inventory")

func add_piece_to_inventory(piece):
	if !piece_inventory.has(piece):
		piece_inventory[piece] = 0
		
		piece_inventory[piece] += 1
	else:
		piece_inventory[piece] += 1
	
	PieceEvents.picked_up_piece.queue_free()
	PieceEvents.picked_up_piece = null
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	
	
	print(piece_inventory)
	
