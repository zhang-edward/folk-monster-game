extends Node2D

var switching = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	%DialogueBox.init("Night has fallen...")
	%DialogueBox.dialogue_finished.connect(_on_DialogueBox_dialogue_finished)

func _on_DialogueBox_dialogue_finished():
	if switching:
		return
	switching = true
	SceneTransition.change_scene_to_file("res://scenes/Main.tscn")