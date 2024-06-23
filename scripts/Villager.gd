class_name Villager
extends CharacterBody2D

const FLEE_DIST_THRESHOLD = 200
const MAX_HEALTH = 10

@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables
@onready var _state_machine: StateMachine = get_node("StateMachine")
@onready var _sprite: AnimatedSprite2D = $Sprite
@onready var player: Player = get_node("/root/Main/Player") as Player

var _corpse_scene = preload ("res://prefabs/Corpse.tscn")
var _effect_scene = preload ("res://prefabs/Effect.tscn")
var _blood_splatter: SpriteFrames = preload ("res://animations/BloodSplatter.tres")
var _blood_splatter_particles: PackedScene = preload ("res://prefabs/BloodSplatterParticles.tscn")

var curr_health

func _ready():
	var villager_num = randi() % 3 + 1
	curr_health = MAX_HEALTH
	_sprite.frames = load("res://animations/Villager" + str(villager_num) + ".tres")
	
func die():
	_player_variables.player_score += 1

	var corpse = _corpse_scene.instantiate() as Corpse
	add_sibling(corpse)
	var v = Vector2(randf() * 200 - 100, randf() * 200 - 100)
	corpse.init(global_position, v, _sprite.sprite_frames.get_frame_texture("die", 0))
	queue_free()
	

func _show_hit_flash():
	_sprite.modulate = Color(1, 0, 0)
	var timer = Timer.new()
	timer.autostart = true
	timer.wait_time = 0.25
	timer.one_shot = true
	add_sibling(timer)
	timer.timeout.connect(_on_flash_complete)
	

func _on_flash_complete():
	_sprite.modulate = Color(1, 1, 1)
	

func _show_damage_number(damage: int):
	pass

func damage():
	var damage = player.calculate_damage()
	curr_health = clamp(curr_health - damage, 0, INF)
	_show_hit_flash()
	_show_damage_number(damage)
	if (curr_health == 0):
		die()
		
	var effect = _effect_scene.instantiate() as AnimatedSprite2D
	effect.sprite_frames = _blood_splatter
	effect.modulate = Color.RED
	effect.position = position
	var angle = get_angle_to(player.global_position) - PI / 2
	effect.rotation = angle
	effect.play()
	add_sibling(effect)

	var particles = _blood_splatter_particles.instantiate() as CPUParticles2D
	particles.global_position = global_position
	particles.direction = player.position - position
	particles.emitting = true
	add_sibling(particles)
