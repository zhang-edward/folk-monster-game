extends Node

const MAX_VILLAGERS = 10
@export var villager_scene: PackedScene
var villagers = []

func spawn_villagers():
	var living_villagers = villagers.filter(check_villager_alive)
	if living_villagers.size() < MAX_VILLAGERS:
		var villager = villager_scene.instantiate()
		villager.global_position = self.global_position
		villagers.append(villager)
		add_sibling(villager)

func check_villager_alive(villager: Villager):
	return is_instance_valid(villager) and villager._health > 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	timer.autostart = true
	timer.one_shot = false
	timer.wait_time = 3.5
	var callable = Callable(self, "spawn_villagers")
	timer.connect("timeout", callable)
	add_child(timer)
