extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	%PlayButton.pressed.connect(_on_PlayButton_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_PlayButton_pressed():
	%AnimationPlayer.play("Start")
	await get_tree().create_timer(2.0).timeout
	SceneTransition.change_scene_to_file("res://scenes/PreGameScene.tscn")
