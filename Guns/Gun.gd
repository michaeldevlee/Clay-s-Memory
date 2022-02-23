extends Resource
class_name Gun

export var name : String
export var damage = 1
export (String, "BURST", "SEMI", "STICKY", "CHARGE") var shoot_pattern = "SEMI"
export var bullet : Resource
export var cool_down_time : float = 0.5
export var texture : Texture
