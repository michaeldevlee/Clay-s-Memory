extends CanvasLayer

func _on_Restart_button_up():
	LevelManager.emit_signal("level_restart_started")
	print('restart')
