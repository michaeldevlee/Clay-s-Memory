extends Node2D

export (String, "END_OF_LEVEL", "BOSS_FIGHT") var trigger_type = "END_OF_LEVEL"

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		match trigger_type:
			"END_OF_LEVEL":
				LevelManager.emit_signal("level_finished")

