class_name Villager
extends CharacterBody2D

@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables
@onready var _state_machine: StateMachine = get_node("StateMachine")
@onready var player: Player = get_node("/root/Main/Player") as Player
const FLEE_DIST_THRESHOLD = 200

func damage():
	_player_variables.player_score += 1
	queue_free()
