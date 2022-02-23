extends CanvasLayer

export var plasma_gun : Resource
export var shot_gun : Resource
export var sticky_gun : Resource


var shop_inventory = {
	plasma_gun : 1,
	shot_gun : 1,
	sticky_gun : 1
}

export var gun_name_path : NodePath
export var left_arrow_path : NodePath
export var right_arrow_path : NodePath
export var gun_texture_path : NodePath
export var price_path : NodePath

var gun_name
var left_arrow
var right_arrow
var gun_texture
var price

func _ready():
	gun_name = get_node(gun_name_path)
	left_arrow = get_node(left_arrow_path)
	right_arrow = get_node(right_arrow_path)
	gun_texture = get_node(gun_texture_path)
	price = get_node(price_path)
	
	if gun_name:
		gun_name.set_text(plasma_gun.name)
	
	if gun_texture:
		gun_texture.set_texture(plasma_gun.texture)

