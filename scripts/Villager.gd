class_name Villager
extends CharacterBody2D

@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables
@onready var _state_machine: StateMachine = get_node("StateMachine")
@onready var _sprite: AnimatedSprite2D = $Sprite
@onready var player: Player = get_node("/root/Main/Player") as Player
const FLEE_DIST_THRESHOLD = 200

func _ready():
	var villager_num = randi() % 3 + 1
	print(villager_num)
	_sprite.frames = load("res://animations/Villager" + str(villager_num) + ".tres")

func damage():
	_player_variables.player_score += 1
	queue_free()
