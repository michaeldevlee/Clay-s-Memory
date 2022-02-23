extends Node2D

export (String, "END_OF_LEVEL", "BOSS_FIGHT", "BARRICADE") var trigger_type = "END_OF_LEVEL"

signal update_barricade_status(status)

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		match trigger_type:
			"END_OF_LEVEL":
				LevelManager.emit_signal("level_finished")
			"BARRICADE":
				emit_signal("update_barricade_status", true)

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		match trigger_type:
			"BARRICADE":
				emit_signal("update_barricade_status", false)
