class_name PowerUpSelect
extends Node2D

@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables
@onready var score = $CanvasLayer/Control/Score as Label
@onready var power_up_boxes: Array[PowerUpBox] = [
	%PowerUp as PowerUpBox,
	%PowerUp2 as PowerUpBox,
	%PowerUp3 as PowerUpBox
]

const POWER_UPS = [
	{
		"name": "Attack Up",
		"type": PlayerVariables.PowerUpTypes.AttackUp,
		"description": "Increase damage of basic attack by 5",
		"cost": 10
	},
	{
		"name": "Attack Speed Up",
		"type": PlayerVariables.PowerUpTypes.AttackSpeed,
		"description": "Increase attack speed by 10%",
		"cost": 10
	},
#	{
#		"name": "Defense Up",
#		"type": PlayerVariables.PowerUpTypes.DefenseUp,
#		"description": "Decrease incoming damage by 5",
#		"cost": 2
#	},
	{
		"name": "Speed Up",
		"type": PlayerVariables.PowerUpTypes.SpeedUp,
		"description": "Increase movement speed by 10",
		"cost": 10
	},
	{
		"name": "Time Warp",
		"type": PlayerVariables.PowerUpTypes.TimeWarp,
		"description": "Increase length of the night by 5 seconds",
		"cost": 25
	},
	{
		"name": "Soul Harvest Up",
		"type": PlayerVariables.PowerUpTypes.SoulHarvest,
		"description": "Harvest 2 souls per kill",
		"cost": 50
	},
#	{
#		"name": "Acid Spit",
#		"type": PlayerVariables.PowerUpTypes.AcidSpit,
#		"description": "Launch an acid ball forward",
#		"upgradeDescription": "Launch 1 more acid",
#		"cost": 3
#	},
#	{
#		"name": "Lunge",
#		"type": PlayerVariables.PowerUpTypes.Lunge,
#		"description": "Charge forward rapidly",
#		"upgradeDescription": "Lunge further",
#		"cost": 3
#	},
#	{
#		"name": "Fire Breath",
#		"type": PlayerVariables.PowerUpTypes.FireBreath,
#		"description": "Breath a cone of fire in front of you",
#		"upgradeDescription": "Impact a wider area of effect",
#		"cost": 3
#	}
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
	PlayerVariables.player_score_updated.connect(on_score_updated)
		
func on_score_updated():
	score.text = "Available Points: " + str(_player_variables.player_score)

func on_continue():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
