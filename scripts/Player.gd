class_name Player
extends CharacterBody2D

const BASE_SPEED = 250
const BASE_DAMAGE = 20
const LUNGE_BASE_DAMAGE = 10
const DAMAGE_UPGRADE_INCREMENT = 5
const SPEED_UPGRADE_INCREMENT = 25
const BLOOD_COLOR = 0x7150f8FF

var hitbox_scene: PackedScene = preload ("res://prefabs/Hitbox.tscn")
var health = 100

@onready var sprite = $Sprite
@onready var effect = $Effect
@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables

var _effect_scene = preload ("res://prefabs/Effect.tscn")
var _blood_splatter: SpriteFrames = preload ("res://animations/PlayerHitEffect.tres")
var _blood_splatter_particles: PackedScene = preload ("res://prefabs/BloodSplatterParticles.tscn")

func calculate_attr_with_powerup(power_up_name: PlayerVariables.PowerUpTypes, base_val: float, incr: float):
	var power_up_level = _player_variables.player_powerup_levels[power_up_name]
	return base_val + (power_up_level * incr)

func attack(attack_hand: String, attack_number: String, is_lunge: bool):
	var effect_offset = Vector2( - 50, 0) if sprite.flip_h else Vector2(50, 0)
	effect.position = effect_offset
	effect.flip_h = sprite.flip_h
	effect.show()
	effect.play("slash_" + attack_hand + attack_number)
	$SlashSound.play()

	var hitbox = hitbox_scene.instantiate()
	add_child(hitbox)
	var hitbox_offset = Vector2( - 50, 0) if sprite.flip_h else Vector2(50, 0)
	
	var damage = calculate_attr_with_powerup(PlayerVariables.PowerUpTypes.AttackUp, BASE_DAMAGE, DAMAGE_UPGRADE_INCREMENT)
	if is_lunge:
		damage = calculate_attr_with_powerup(PlayerVariables.PowerUpTypes.LungeDamage, LUNGE_BASE_DAMAGE, DAMAGE_UPGRADE_INCREMENT)		
	hitbox.init(hitbox_offset, Vector2(100, 100), 0.25, Hitbox.CollideableTypes.Villager, damage)

func damage(amt: int):
	health -= amt
	if !$HurtSound.playing:
		$HurtSound.play()

	var hit_effect = _effect_scene.instantiate() as AnimatedSprite2D
	hit_effect.sprite_frames = _blood_splatter
	hit_effect.modulate = Color.hex(BLOOD_COLOR)
	hit_effect.position = position
	var angle = randf() * PI * 2
	hit_effect.rotation = angle
	hit_effect.play()
	hit_effect.offset = Vector2(randf() * 20 - 10, randf() * 20 - 10)
	add_sibling(hit_effect)

	var particles = _blood_splatter_particles.instantiate() as CPUParticles2D
	particles.global_position = global_position
	particles.direction = Vector2(randf(), randf())
	particles.color = Color.hex(BLOOD_COLOR)
	particles.amount = 50
	particles.speed_scale = 2
	particles.emitting = true
	add_sibling(particles)

	Engine.time_scale = 0.2
	sprite.modulate = Color(1, 0, 0)
	await get_tree().create_timer(0.25, true, false, true).timeout

	Engine.time_scale = 1.0
	sprite.modulate = Color(1, 1, 1)

	if (health <= 0):
		get_tree().change_scene_to_file("res://scenes/GameOver.tscn")
