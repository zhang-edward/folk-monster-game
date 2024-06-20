extends Label

@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "Score: " + str(_player_variables.player_score)
