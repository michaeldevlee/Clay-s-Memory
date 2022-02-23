extends TextureRect

onready var collision_shape = get_node("StaticBody2D/CollisionShape2D")

export var trigger_path : NodePath
export var removal_key : NodePath

var trigger
var key

func _ready():
	deactivate()
	if trigger_path and removal_key:
		trigger = get_node(trigger_path)
		trigger.connect("update_barricade_status", self, "update_status")
		
		key = get_node(removal_key)
		key.connect("all_buttons_pressed", self, "remove")

func update_status(value):
	if value == true:
		activate()
	else:
		deactivate()

func activate():
	visible = true
	collision_shape.set_deferred("disabled", false)

func deactivate():
	visible = false
	collision_shape.set_deferred("disabled", true)

func remove():
	queue_free()
