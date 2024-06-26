extends Node

const MAX_VILLAGERS = 10
@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables
@export var villager_scene: PackedScene
@export var guard_scene: PackedScene
var villagers: Array[Villager] = []
var timer: Timer

const BASE_GUARD_SPAWN_RATE = 25
const GUARD_SPAWN_RATE_INCR = 5
const ROUND_PER_SPAWN_RATE_INCR = 3

func spawn_villagers():
	var living_villagers = villagers.filter(check_villager_alive)
	if living_villagers.size() < MAX_VILLAGERS:
		var scene_to_spawn = guard_scene if should_spawn_guard() else villager_scene
		var villager = scene_to_spawn.instantiate()
		villager.global_position = self.global_position
		villagers.append(villager)
		add_sibling(villager)
	timer.wait_time = randf() * 3 + 3

func check_villager_alive(villager):
	return is_instance_valid(villager) and villager._health > 0
	
func should_spawn_guard():
	var spawn_threshold = BASE_GUARD_SPAWN_RATE + (int(_player_variables.generation_number) / int(ROUND_PER_SPAWN_RATE_INCR)) * GUARD_SPAWN_RATE_INCR
	spawn_threshold = clamp(spawn_threshold, 0, 100)
	return randi_range(1, 100) <= spawn_threshold

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.autostart = true
	timer.one_shot = false
	timer.wait_time = 1
	timer.timeout.connect(spawn_villagers)
	# var callable = Callable(self, "spawn_villagers")
	# timer.connect("timeout", callable)
	add_child(timer)
