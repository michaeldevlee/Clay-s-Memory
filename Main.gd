extends Node2D

export var current_level : NodePath
export var player_path : NodePath


var next_level
var tutorial_level = preload("res://Levels/Tutorial Level.tscn")
var level_1 = preload("res://Levels/Level 1.tscn")
var level_2 = preload("res://Levels/Level 2.tscn")
var index = 0

var level_list = [
	tutorial_level,
	level_1,
	level_2
]

onready var level_load_node = get_node("Level")
onready var camera = get_node("Camera2D")
var player

func _ready():
	player = get_node(player_path)
	LevelManager.connect("level_finished" ,self, "load_next_level")

func load_next_level():
	player.can_move = false
	SceneTransitionHandler.fade_out()
	yield(SceneTransitionHandler.anim_player, "animation_finished")
	camera.limit_left = 0
	camera.limit_right = 2048
	camera.limit_bottom = 600
	player.global_position = Vector2(50, 500)
	index += 1
	if index < level_list.size():
		get_node(current_level).queue_free()
		var instance = level_list[index].instance()
		level_load_node.add_child(instance)
		current_level = instance.get_path()
		print(instance)
		SceneTransitionHandler.fade_in()
		player.can_move = true
	
