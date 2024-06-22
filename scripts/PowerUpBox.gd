class_name PowerUpBox
extends ColorRect

@onready var powerup_name_label: Label = $Name
@onready var select_button: Button = $SelectButton
@onready var powerup_description_label: Label = $MarginContainer/Description
@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables

func init_powerup(power_up) -> void:
	powerup_name_label.text = power_up.name
	powerup_description_label.text = power_up.description
	var curr_powerup_level: int = _player_variables.player_powerup_levels[power_up.type]
	select_button.text = "Get (" + str(power_up.cost * pow(2, curr_powerup_level)) + "SP)"
