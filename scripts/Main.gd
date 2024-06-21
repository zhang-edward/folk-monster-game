extends Node2D

@export var mob_scene: PackedScene
@export var num_villagers = 10

@onready var round_timer: Timer = $RoundTimer

func _ready():
	# Spawns villagers
	var villagers = []
	for i in range(num_villagers):
		var villager = mob_scene.instantiate()
		villager.global_position = $Player.global_position
		villager.global_position.x += (i + 1) * 10
		villagers.append(villager)
		add_child(villager)
	
	# Start the round timer
	round_timer.start()
