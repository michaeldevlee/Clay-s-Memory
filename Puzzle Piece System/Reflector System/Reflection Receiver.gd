extends Node2D
class_name Reflection_Receiver

signal receiver_status_changed (receiver, status)

var is_being_hit_by_laser : bool = false
var fully_shined : bool = false setget update_receiver_status
var laser_source

onready var anim_player = get_node("AnimationPlayer")
onready var kinematic_body = get_node("KinematicBody2D")

func _ready():
	set_physics_process(false)

func update_receiver_status(value):
	fully_shined = value
	emit_signal("receiver_status_changed", self, fully_shined)

func detect_laser():
	if laser_source is Laser and laser_source.is_colliding():
		if laser_source.get_collider() == kinematic_body and !is_being_hit_by_laser:
			if laser_source.is_casting == true:
				is_being_hit_by_laser = true
				emit_signal("receiver_status_changed", self, is_being_hit_by_laser)
				anim_player.play("On")

func _on_Laser_Detection_Area_area_entered(area):
	if area.name == "Laser Path" and laser_source == null:
		laser_source = area.owner
		set_physics_process(true)

func _on_Laser_Detection_Area_area_exited(area):
	if area.name == "Laser Path":
		laser_source = null
		is_being_hit_by_laser = false
		emit_signal("receiver_status_changed", self, is_being_hit_by_laser)
		set_physics_process(false)
		anim_player.play("Off")

func _physics_process(delta):
	detect_laser()
