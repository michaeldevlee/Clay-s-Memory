extends KinematicBody2D
class_name Player

export (int) var speed = 300
export (int) var gravity = 900
export var jump_impulse = 600
export var gun : Resource
var bullet
var dash_multiplier = 1
var velocity : Vector2 = Vector2()

var hp = 300

onready var R_hand_sprite = get_node("Rig/Body/Hands/R Hand")
onready var L_hand_sprite = get_node("Rig/Body/Hands/L Hand")
onready var R_bullet_spawn_point = get_node("Rig/R Hand Spawn")
onready var L_bullet_spawn_point = get_node("Rig/L Hand Spawn")
onready var cool_down_timer = get_node("Cool Down Timer")
onready var body_anim_player = get_node("Rig/Body Animator")
onready var gun_anim_player = get_node("Rig/Gun Animator")
onready var rig = get_node("Rig")

var is_dashing : bool = false
var player_facing_direction = "Right"
var can_move : bool = true
var cool_down_time : float

var player_directions = {
	"Right" : 1,
	"Left" : -1
}

func _ready():
	ShopEvents.connect("shop_opened", self, "stop_player_movement")
	ShopEvents.connect("shop_closed", self, "resume_player_movement")
	
	if gun and gun is Gun:
		R_hand_sprite.texture = gun.texture
		L_hand_sprite.texture = gun.texture
		
		cool_down_time = gun.cool_down_time
		
		if PlayerEvents.bullets.has(gun.bullet):
			var index = PlayerEvents.bullets.find(gun.bullet)
			
			bullet = PlayerEvents.bullets[index]
		

func resume_player_movement():
	can_move = true

func stop_player_movement():
	can_move = false

func move_from_input():
	
	if !can_move:
		return
	
	velocity.x = 0
	if(Input.is_action_pressed("MOVE_LEFT")):
		velocity.x -= speed * dash_multiplier
		body_anim_player.play("Player Walk")
	elif(Input.is_action_pressed("MOVE_RIGHT")):
		velocity.x += speed * dash_multiplier
		body_anim_player.play("Player Walk")
	else:
		body_anim_player.play("Player Idle")
	if(Input.is_action_just_pressed("JUMP")) and is_on_floor():
		velocity.y -= jump_impulse
	velocity = move_and_slide(velocity, Vector2.UP, true)

func play_shaking_anim():
	body_anim_player.play("Alive Transition")

func play_alive_anim():
	body_anim_player.play("Alive")
	yield(body_anim_player,"animation_finished")
	can_move = true
	AudioEngine.play_music(AudioEngine.level_music, -3)


func apply_gravity(delta):
	velocity.y += gravity * delta

func update_sprite_direction():
	if velocity.x < 0:
		player_facing_direction = "Left"
		rig.scale.x = -1
		#bullet_spawn_point.position.x *= -1
	elif velocity.x > 0:
		player_facing_direction = "Right"
		rig.scale.x = 1
		#bullet_spawn_point.position.x = abs(bullet_spawn_point.position.x)
		
func shoot_projectile_from_input():
	if(Input.is_action_just_pressed("SHOOT") and cool_down_timer.is_stopped()):
		if bullet:
			var bullet_instance = bullet.instance()
			owner.add_child(bullet_instance)
			if bullet_instance.is_in_group("Bullet"):
				bullet_instance.global_position = R_bullet_spawn_point.global_position
				bullet_instance.update_player_direction(player_directions[player_facing_direction])
				
				cool_down_timer.start(cool_down_time)
#func take_damage(amount):
#	if hp <= 0:
#		queue_free()
#		EventBus.emit_signal("menu_item_initiated", "Death Screen")
#	hp -= amount
	
func initialize_player():
	can_move = true

#func register_signals():
#	EventBus.connect("player_hit", self, "take_damage")
##	EventBus.connect("tutorial_area_started", self, "initialize_player")

func _physics_process(delta):
	move_from_input()
	apply_gravity(delta)
	update_sprite_direction()
	shoot_projectile_from_input()
