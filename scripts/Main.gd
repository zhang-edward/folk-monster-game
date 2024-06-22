extends Node2D

@export var mob_scene: PackedScene
@export var num_villagers = 10

@onready var round_timer: Timer = $RoundTimer
@onready var time_remaining_label = $CanvasLayer/GUI/TimeRemaining as Label

const TIME_LIMIT_SECONDS = 10
var time_remaining

# Called when the node enters the scene tree for the first time.
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
	# Set a time limit for the night
	time_remaining = TIME_LIMIT_SECONDS
	time_remaining_label.text = "Time remaining: " + str(time_remaining)
	var timer = Timer.new()
	timer.autostart = true
	timer.wait_time = 1
	timer.one_shot = false
	var callable = Callable(self, "on_timer_tick")
	timer.timeout.connect(callable)
	add_child(timer)


func on_timer_tick():
	if time_remaining == 0:
		get_tree().change_scene_to_file("res://scenes/PowerUpSelect.tscn")
	else:
		time_remaining -= 1
		time_remaining_label.text = "Time remaining: " + str(time_remaining)
