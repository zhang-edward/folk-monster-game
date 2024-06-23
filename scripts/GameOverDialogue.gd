extends Control

@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables

# Called when the node enters the scene tree for the first time.
func _ready():
	var text = ""
	text += "And so, after many dark nights and untold sorrow across [X generations], the town guard mustered their courage and faced the beast as it attacked the village.\n\n"
	text += "With unwavering resolve and sheer determination, they fought fiercely, striking down the creature in the midst of its rampage.\n\n"
	text += "The village was finally freed from its terror, and peace returned at last.\n\n"
	text += "Yet...\n\n"
	text += "The shadows of those harrowing nights still linger, a grim reminder that true evil never truly dies, but merely slumbers, waiting for the darkness to rise once more."
	
	var num_generations = _player_variables.generation_number
	var generation_str = str(num_generations) + " generation" if num_generations == 1 else str(num_generations) + " generations"
	text = text.replace("[X generations]", "[color=red]" + generation_str + "[/color]")
	$DialogueBox.init(text)
	$DialogueBox.dialogue_finished.connect(_on_DialogueBox_dialogue_finished)
	$RestartButton.pressed.connect(_on_RestartButton_pressed)
	$RestartButton.hide()

	$MainMenuButton.pressed.connect(_on_MainMenuButton_pressed)
	$MainMenuButton.hide()

func _on_DialogueBox_dialogue_finished():
	$RestartButton.show()
	$MainMenuButton.show()

func _on_RestartButton_pressed():
	reset_player_variables()
	SceneTransition.change_scene_to_file("res://scenes/PreGameScene.tscn")

func _on_MainMenuButton_pressed():
	reset_player_variables()
	SceneTransition.change_scene_to_file("res://scenes/MainMenu.tscn")


func reset_player_variables():
	_player_variables.generation_number = 1
	_player_variables.kill_count = 0
	_player_variables.player_score = 0
	_player_variables.reset_player_powerup_level()
