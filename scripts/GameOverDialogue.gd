extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var text = ""
	text += "And so, after many dark nights and untold sorrow across generations, the town guard mustered their courage and faced the beast as it attacked the village.\n\n"
	text += "With unwavering resolve and sheer determination, they fought fiercely, striking down the creature in the midst of its rampage.\n\n"
	text += "The village was finally freed from its terror, and peace returned at last.\n\n"
	text += "Yet...\n\n"
	text += "The shadows of those harrowing nights still linger, a grim reminder that true evil never truly dies, but merely slumbers, waiting for the darkness to rise once more."
	$DialogueBox.init(text)
	$DialogueBox.dialogue_finished.connect(_on_DialogueBox_dialogue_finished)
	$RestartButton.pressed.connect(_on_RestartButton_pressed)
	$RestartButton.hide()

func _on_DialogueBox_dialogue_finished():
	$RestartButton.show()

func _on_RestartButton_pressed():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
