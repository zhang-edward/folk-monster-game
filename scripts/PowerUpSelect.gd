class_name PowerUpSelect
extends Node2D

@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables
@onready var score = $CanvasLayer/Control/Score as Label
@onready var power_up_boxes: Array[PowerUpBox] = [
	$CanvasLayer/Control/HBoxContainer/PowerUp as PowerUpBox,
	$CanvasLayer/Control/HBoxContainer/PowerUp2 as PowerUpBox,
	$CanvasLayer/Control/HBoxContainer/PowerUp3 as PowerUpBox
]

const POWER_UPS = [
	{
		"name": "Attack Up",
		"type": PlayerVariables.PowerUpTypes.AttackUp,
		"description": "Increase damage of basic attack by 1",
		"cost": 2
	},
	{
		"name": "Defense Up",
		"type": PlayerVariables.PowerUpTypes.DefenseUp,
		"description": "Decrease incoming damage by 1",
		"cost": 2
	},
	{
		"name": "Speed Up",
		"type": PlayerVariables.PowerUpTypes.SpeedUp,
		"description": "Increase movement speed by 10",
		"cost": 2
	},
	{
		"name": "Acid Spit",
		"type": PlayerVariables.PowerUpTypes.AcidSpit,
		"description": "Launch an acid ball forward",
		"upgradeDescription": "Launch 1 more acid",
		"cost": 3
	},
	{
		"name": "Lunge",
		"type": PlayerVariables.PowerUpTypes.Lunge,
		"description": "Charge forward rapidly",
		"upgradeDescription": "Lunge further",
		"cost": 3
	},
	{
		"name": "Fire Breath",
		"type": PlayerVariables.PowerUpTypes.FireBreath,
		"description": "Breath a cone of fire in front of you",
		"upgradeDescription": "Impact a wider area of effect",
		"cost": 3
	}
]

func _ready():
	score.text = "Available Points: " + str(_player_variables.player_score)
	var random_powerups = POWER_UPS.duplicate()
	randomize()
	random_powerups.shuffle()
	for i in range(0, power_up_boxes.size()):
		var power_up = random_powerups[i]
		var power_up_box = power_up_boxes[i]
		power_up_box.init_powerup(power_up)
		
func on_select_powerup(power_up):
	_player_variables.player_powerup_levels[power_up.type] += 1
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_button_pressed():
	pass # Replace with function body.
