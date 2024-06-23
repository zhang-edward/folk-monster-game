extends Node2D

var switching = false
@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables

# Called when the node enters the scene tree for the first time.
func _ready():
	var num_generation = _player_variables.generation_number 
	var text = "Night has fallen...\n\n"
	text += "[color=red]" + str(num_generation) + get_ordinal_suffix(num_generation) + " generation...[/color]"
	_player_variables.kill_count = 0
	%DialogueBox.init("[center]" + text + "[/center]")
	%DialogueBox.dialogue_finished.connect(_on_DialogueBox_dialogue_finished)

func _on_DialogueBox_dialogue_finished():
	if switching:
		return
	switching = true
	SceneTransition.change_scene_to_file("res://scenes/main.tscn")

func get_ordinal_suffix(num_generation: int):
	var modded = num_generation % 20
	if modded == 1:
		return "st"
	elif modded == 2:
		return "nd"
	elif modded == 3:
		return "rd"
	else:
		return "th"
