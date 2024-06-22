class_name PowerUpBox
extends ColorRect

@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables
@onready var powerup_name_label: Label = $Name
@onready var select_button: Button = $SelectButton
@onready var powerup_description_label: Label = $MarginContainer/Description
@onready var power_up_select = $"../../../.." as PowerUpSelect

var power_up = null
var power_up_cost = 0

const ABILITY_TYPES = [
	PlayerVariables.PowerUpTypes.AcidSpit,
	PlayerVariables.PowerUpTypes.FireBreath,
	PlayerVariables.PowerUpTypes.Lunge,
]

func init_powerup(power_up) -> void:
	self.power_up = power_up
	powerup_name_label.text = power_up.name
	powerup_description_label.text = power_up.description
	var curr_powerup_level: int = _player_variables.player_powerup_levels[power_up.type]
	power_up_cost = power_up.cost * pow(2, curr_powerup_level)
	if power_up_cost <= _player_variables.player_score:
		select_button.modulate = Color(1, 0, 0)
	else:
		select_button.modulate = Color(1, 0, 0)
	select_button.text = "Get (" + str(power_up_cost) + "SP)"

func select_powerup():
	if power_up_cost <= _player_variables.player_score:
		_player_variables.score -= power_up_cost
		power_up_select.on_select_powerup(power_up)

func is_ability_upgrade(powerup_name) -> void:
	pass
