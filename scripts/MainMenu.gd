extends Node2D

@onready var main_menu = %Menu
@onready var tutorial = %Tutorial

# Called when the node enters the scene tree for the first time.
func _ready():
	%PlayButton.pressed.connect(_on_PlayButton_pressed)
	%TutorialButton.pressed.connect(_on_TutorialButton_pressed)
	%BackButton.pressed.connect(_on_BackButton_pressed)

func _on_TutorialButton_pressed():
	tutorial.show()
	main_menu.hide()

func _on_BackButton_pressed():
	tutorial.hide()
	main_menu.show()

func _on_PlayButton_pressed():
	%AnimationPlayer.play("Start")
	await get_tree().create_timer(2.0).timeout
	SceneTransition.change_scene_to_file("res://scenes/PreGameScene.tscn")
