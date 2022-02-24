extends RayCast2D
class_name Laser

onready var line = get_node("Line2D")
onready var tween = get_node("Tween")
onready var cast_particles = get_node("Casting Particle")
onready var coll_particles = get_node("Colliding Particle")
onready var beam_particles = get_node("Colliding Particle2")
onready var laser_path = get_node("Laser Path/CollisionShape2D")

export var is_casting := false
export var originating_laser := false
var base_casting_point = 1000
var target

func _ready():
	line.points[1] = Vector2.ZERO
	set_is_casting(is_casting)

func _physics_process(delta):
	var cast_point := cast_to
	force_raycast_update()
	
	coll_particles.emitting = is_colliding()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		coll_particles.global_rotation = get_collision_normal().angle()
		coll_particles.position = cast_point
		

	line.points[1] = cast_point
	beam_particles.position = cast_point * 0.5
	beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5
	
func deactivate():
	laser_path.set_deferred("disabled", true)

func activate():
	laser_path.set_deferred("disabled", false)

func set_is_casting(cast:bool):
	is_casting = cast

	beam_particles.emitting = is_casting
	cast_particles.emitting = is_casting
	
	if is_casting:
		appear()
		
	else:
		coll_particles.emitting = false
		disappear()

	set_physics_process(is_casting)

func appear():
	tween.stop_all()
	tween.interpolate_property(line, "width", 0, 10.0, 0.2)
	tween.start()
	
func disappear():
	tween.stop_all()
	tween.interpolate_property(line, "width", 10.0, 0, 0.1)
	tween.start()
