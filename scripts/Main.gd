extends Node2D
class_name Main

@onready var time_remaining_label = $CanvasLayer/GUI/TimeRemaining as Label
@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables
@onready var player: Player = %Player as Player
@onready var camera: Camera2D = get_node("Player/Camera2D") as Camera2D

const TIME_LIMIT_SECONDS = 60
var mob_scene: PackedScene = preload ("res://prefabs/Villager.tscn")
var guard_scene: PackedScene = preload ("res://prefabs/GuardVillager.tscn")

var time_remaining
var _switching_scenes = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set a time limit for the night
	time_remaining = player.calculate_attr_with_powerup(PlayerVariables.PowerUpTypes.TimeWarp, TIME_LIMIT_SECONDS, 5)

func _process(delta):
	# Prevent the player from going out of bounds of the camera's limits.
	player.position.x = clamp(player.position.x, camera.limit_left, camera.limit_right)
	player.position.y = clamp(player.position.y, camera.limit_top, camera.limit_bottom)

	time_remaining_label.text = "Time remaining: " + str(snapped(time_remaining, 1))
	if time_remaining > 0:
		time_remaining -= delta

	if time_remaining <= 0 and not _switching_scenes:
		_switching_scenes = true
		%SceneAnimationPlayer.play("fade_in")
		await %SceneAnimationPlayer.animation_finished
		SceneTransition.change_scene_to_file("res://scenes/PowerUpSelect.tscn", 3.0)
