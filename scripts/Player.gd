class_name Player
extends CharacterBody2D

const BASE_SPEED = 250
const BASE_DAMAGE = 20
const DAMAGE_UPGRADE_INCREMENT = 5
const SPEED_UPGRADE_INCREMENT = 25

var hitbox_scene: PackedScene = preload ("res://prefabs/Hitbox.tscn")

@onready var sprite = $Sprite
@onready var effect = $Effect
@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables

func calculate_attr_with_powerup(power_up_name: PlayerVariables.PowerUpTypes, base_val: float, incr: float):
	var power_up_level = _player_variables.player_powerup_levels[power_up_name]
	return base_val + (power_up_level * incr)

func attack(attack_hand: String, attack_number: String):
	var effect_offset = Vector2( - 50, 0) if sprite.flip_h else Vector2(50, 0)
	effect.position = effect_offset
	effect.flip_h = sprite.flip_h
	effect.show()
	effect.play("slash_" + attack_hand + attack_number)
	get_node("SlashSound").play()

	var hitbox = hitbox_scene.instantiate()
	add_child(hitbox)
	var hitbox_offset = Vector2( - 50, 0) if sprite.flip_h else Vector2(50, 0)
	hitbox.init(hitbox_offset, Vector2(100, 100), 0.25, Hitbox.CollideableTypes.Villager, randi() % 50 + 30)
