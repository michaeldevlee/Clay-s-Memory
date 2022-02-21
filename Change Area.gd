extends Area2D

export (String, "RIGHT", "LEFT", "UP", "DOWN") var direction = "RIGHT"
export var direction_amt : Vector2

onready var collision_shape = get_node("CollisionShape2D")
