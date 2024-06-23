extends Label

@export var _main_scene: Node2D

@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "Infamy: " + str(_player_variables.player_score)
