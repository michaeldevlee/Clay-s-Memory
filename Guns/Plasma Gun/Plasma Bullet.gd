extends Sprite

onready var trail = get_node("Trail")

export var bullet_speed = 100

var player_direction = 1

func execute_shoot_pattern(delta):
	position.x += player_direction * bullet_speed * delta
	trail.scale.x = player_direction
	
func _physics_process(delta):
	execute_shoot_pattern(delta)

func _on_Hit_Area_body_entered(body):
	print(body)
