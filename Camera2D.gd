extends Camera2D

func _ready():
	LevelManager.connect("room_change_initiated", self, "change_rooms")

func change_rooms(direction : String, direction_amt : Vector2):
	match direction:
		"LEFT":
			limit_right -= direction_amt.x
			limit_left -= direction_amt.x
		"RIGHT":
			limit_right += direction_amt.x
			limit_left += direction_amt.x
	
