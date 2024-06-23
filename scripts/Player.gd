class_name Player
extends CharacterBody2D

const SPEED = 300.0
const BASE_DAMAGE = 1

var is_attacking = false

@onready var animated_sprite = $Sprite
@onready var effect = $Effect
@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables

func on_attack_complete():
	is_attacking = false

func calculate_damage():
	var attack_level = _player_variables.player_powerup_levels[PlayerVariables.PowerUpTypes.AttackUp]
	return BASE_DAMAGE + attack_level
