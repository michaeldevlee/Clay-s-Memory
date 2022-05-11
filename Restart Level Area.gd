extends Area2D



func _on_Restart_Level_Area_body_entered(body):
	if body.name == "Player":
		LevelManager.emit_signal("level_restart_started")
