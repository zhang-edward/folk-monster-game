extends Node2D

var switching = false
@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables

# Called when the node enters the scene tree for the first time.
func _ready():
	_player_variables.kill_count = 0
	%DialogueBox.init("Night has fallen...")
	%DialogueBox.dialogue_finished.connect(_on_DialogueBox_dialogue_finished)

func _on_DialogueBox_dialogue_finished():
	if switching:
		return
	switching = true
	SceneTransition.change_scene_to_file("res://scenes/main.tscn")