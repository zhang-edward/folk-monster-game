class_name Villager
extends CharacterBody2D

@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables
@onready var _state_machine: StateMachine = get_node("StateMachine")
@onready var _sprite: AnimatedSprite2D = $Sprite
@onready var player: Player = get_node("/root/Main/Player") as Player
@export var damage_number: PackedScene
@export var is_guard: bool = false
@onready var _health

var _corpse_scene = preload ("res://prefabs/Corpse.tscn")
var _effect_scene = preload ("res://prefabs/Effect.tscn")
var _blood_splatter: SpriteFrames = preload ("res://animations/BloodSplatter.tres")
var _blood_splatter_particles: PackedScene = preload ("res://prefabs/BloodSplatterParticles.tscn")
var effect = null

const FLEE_DIST_THRESHOLD = 150

# Health
const VILLAGER_BASE_HEALTH = 75
const GUARD_BASE_HEALTH = 150
const HEALTH_INCR = 25
const ROUND_PER_HEALTH_INCR = 5

# Infamy per kill
const VILLAGER_INFAMY_PER_KILL = 1
const GUARD_INFAMY_PER_KILL = 2

func _ready():
	_health = calculate_round_health()
	if is_guard:
		var guard_num = randi() % 2 + 1
		_sprite.frames = load("res://animations/GuardVillager" + str(guard_num) + ".tres")
		effect = $Effect
	else:
		var villager_num = randi() % 4 + 1
		_sprite.frames = load("res://animations/Villager" + str(villager_num) + ".tres")

func calculate_round_health():
	# Make villager health increase every few rounds
	var base_health = GUARD_BASE_HEALTH if is_guard else VILLAGER_BASE_HEALTH
	return base_health + (int(_player_variables.generation_number) / int(ROUND_PER_HEALTH_INCR)) * HEALTH_INCR

func damage(amt: int):
	_health -= amt
	var new_damage_number = damage_number.instantiate()
	new_damage_number.global_position = _sprite.global_position
	new_damage_number.text = str(amt)
	add_sibling(new_damage_number)

	# SFX
	$HitSound.play()

	# Graphics
	player.get_node("%Camera").add_trauma(0.25, 0.25)
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
		var infamy_gain_level = _player_variables.player_powerup_levels[PlayerVariables.PowerUpTypes.InfamyGain]
		var score_per_kill = GUARD_INFAMY_PER_KILL if is_guard else VILLAGER_INFAMY_PER_KILL
		var score_with_mult = score_per_kill * pow(2, infamy_gain_level)
		_player_variables.player_score += score_with_mult
		_player_variables.kill_count += 1
		var corpse = _corpse_scene.instantiate() as Corpse
		add_sibling(corpse)
		var v = Vector2(randf() * 200 - 100, randf() * 200 - 100)
		corpse.init(global_position, v, _sprite.sprite_frames.get_frame_texture("die", 0))
		queue_free()
