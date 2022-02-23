extends Sprite

export var bullet_speed = 1400

onready var bullet_1 = get_node("Sprite2")
onready var bullet_2 = get_node("Sprite3")

var player_direction = 1
var y_direction
var shotgun_shells : Array

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	y_direction = rng.randf_range(-4.0 , 4.0)
	print(y_direction)

func execute_shoot_pattern(delta):
	position.x += player_direction * bullet_speed * delta
	position.y += player_direction * y_direction * delta
	
	update_sprite_directions(delta)

func update_sprite_directions(delta):
	if is_instance_valid(bullet_1) and is_instance_valid(bullet_2):
		bullet_1.position.y += player_direction  * delta + y_direction
		bullet_2.position.y += player_direction  * delta - y_direction 

func _physics_process(delta):
	execute_shoot_pattern(delta)

func _on_Hit_Area_body_entered(body):
	print(body)

func _on_VisibilityNotifier2D_screen_exited():
	bullet_1.queue_free()

func _on_VisibilityNotifier2D_2_screen_exited():
	bullet_2.queue_free()
