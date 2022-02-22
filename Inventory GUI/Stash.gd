extends TextureRect

signal piece_stashed (piece)


func _on_Stash_gui_input(event):
	if PieceEvents.picked_up_piece != null and event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			emit_signal("piece_stashed", PieceEvents.picked_up_piece.sprite_shape)
