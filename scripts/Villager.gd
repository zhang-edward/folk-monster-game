class_name Villager
extends CharacterBody2D

const FLEE_DIST_THRESHOLD = 200

@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables
@onready var _state_machine: StateMachine = get_node("StateMachine")
@onready var _sprite: AnimatedSprite2D = $Sprite
@onready var player: Player = get_node("/root/Main/Player") as Player

var _corpse_scene = preload ("res://prefabs/Corpse.tscn")
var _effect_scene = preload ("res://prefabs/Effect.tscn")
var _blood_splatter: SpriteFrames = preload ("res://animations/BloodSplatter.tres")
var _blood_splatter_particles: PackedScene = preload ("res://prefabs/BloodSplatterParticles.tscn")

func _ready():
	var villager_num = randi() % 3 + 1
	print(villager_num)
	_sprite.frames = load("res://animations/Villager" + str(villager_num) + ".tres")

func damage():
	_player_variables.player_score += 1
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

	var corpse = _corpse_scene.instantiate() as Corpse
	add_sibling(corpse)
	var v = Vector2(randf() * 200 - 100, randf() * 200 - 100)
	corpse.init(global_position, v, _sprite.sprite_frames.get_frame_texture("die", 0))
	queue_free()
