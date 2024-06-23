class_name Player
extends CharacterBody2D

const BASE_SPEED = 250
const BASE_DAMAGE = 20
const DAMAGE_UPGRADE_INCREMENT = 5
const SPEED_UPGRADE_INCREMENT = 25

var is_attacking = false

@onready var animated_sprite = $Sprite
@onready var effect = $Effect
@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables

func on_attack_complete():
	is_attacking = false

func calculate_attr_with_powerup(power_up_name: PlayerVariables.PowerUpTypes, base_val: float, incr: float):
	var power_up_level = _player_variables.player_powerup_levels[power_up_name]
	return base_val + (power_up_level * incr)
