class_name PowerUpSelect
extends Node2D

@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables
@onready var score = $CanvasLayer/Control/Score as Label

func _ready():
	print(_player_variables.player_score)
	score.text = "Available Points: " + str(_player_variables.player_score)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
