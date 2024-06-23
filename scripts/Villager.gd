class_name Villager
extends CharacterBody2D

@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables
@onready var _state_machine: StateMachine = get_node("StateMachine")
@onready var _sprite: AnimatedSprite2D = $Sprite
@onready var player: Player = get_node("/root/Main/Player") as Player
@onready var effect = $Effect
@export var damage_number: PackedScene
@export var is_guard: bool = false

var _corpse_scene = preload ("res://prefabs/Corpse.tscn")
var _effect_scene = preload ("res://prefabs/Effect.tscn")
var _blood_splatter: SpriteFrames = preload ("res://animations/BloodSplatter.tres")
var _blood_splatter_particles: PackedScene = preload ("res://prefabs/BloodSplatterParticles.tscn")

var _health = 100

func _ready():
	if is_guard:
		var guard_num = randi() % 2 + 1
		_sprite.frames = load("res://animations/GuardVillager" + str(guard_num) + ".tres")
	else:
		var villager_num = randi() % 4 + 1
		_sprite.frames = load("res://animations/Villager" + str(villager_num) + ".tres")

func damage(amt: int):
	_health -= amt
	var new_damage_number = damage_number.instantiate()
	new_damage_number.global_position = _sprite.global_position
	new_damage_number.text = str(amt)
	add_sibling(new_damage_number)

	# SFX
	$HitSound.play()

	# Graphics
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

	if (_health <= 0):
		_player_variables.player_score += 1
		var corpse = _corpse_scene.instantiate() as Corpse
		add_sibling(corpse)
		var v = Vector2(randf() * 200 - 100, randf() * 200 - 100)
		corpse.init(global_position, v, _sprite.sprite_frames.get_frame_texture("die", 0))
		queue_free()
