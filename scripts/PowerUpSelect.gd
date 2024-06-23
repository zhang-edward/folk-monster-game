class_name PowerUpSelect
extends Node2D

@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables
@onready var title = $CanvasLayer/Control/Label as Label
@onready var score = $CanvasLayer/Control/Score as Label
@onready var power_up_boxes: Array[PowerUpBox] = [
	%PowerUp as PowerUpBox,
	%PowerUp2 as PowerUpBox,
	%PowerUp3 as PowerUpBox
]
@onready var continue_button = $CanvasLayer/Control/ContinueButton

var is_displaying_powerup = false
var is_finished_displaying_powerup = false

const POWER_UPS = [
	{
		"name": "...inflict horrible wounds!",
		"type": PlayerVariables.PowerUpTypes.AttackUp,
		"description": "Increase damage of basic attack by 5",
		"cost": 10
	},
	{
		"name": "...slash and tear in a frenzy!",
		"type": PlayerVariables.PowerUpTypes.AttackSpeed,
		"description": "Increase attack speed by 10%",
		"cost": 10
	},
	{
		"name": "...shatter weapons with its thick hide!",
		"type": PlayerVariables.PowerUpTypes.DefenseUp,
		"description": "Decrease incoming damage by 5",
		"cost": 10
	},
	{
		"name": "...run faster than the wind!",
		"type": PlayerVariables.PowerUpTypes.SpeedUp,
		"description": "Increase movement speed by 10",
		"cost": 10
	},
	{
		"name": "...make long nights feel longer!",
		"type": PlayerVariables.PowerUpTypes.TimeWarp,
		"description": "Increase length of the night by 5 seconds",
		"cost": 25
	},
	{
		"name": "...strike terror into the hearts of all!",
		"type": PlayerVariables.PowerUpTypes.InfamyGain,
		"description": "Double the amount of infamy gained per kill",
		"cost": 50
	},
#	{
#		"name": "Acid Spit",
#		"type": PlayerVariables.PowerUpTypes.AcidSpit,
#		"description": "Launch an acid ball forward",
#		"upgradeDescription": "Launch 1 more acid",
#		"cost": 3
#	},
	{
		"name": "...leap with deadly force!",
		"type": PlayerVariables.PowerUpTypes.LungeDamage,
		"description": "Increase lunge damage by 5",
		"cost": 10
	},
#	{
#		"name": "Fire Breath",
#		"type": PlayerVariables.PowerUpTypes.FireBreath,
#		"description": "Breath a cone of fire in front of you",
#		"upgradeDescription": "Impact a wider area of effect",
#		"cost": 3
#	}
]

func _ready():
	score.text = "Infamy: " + str(_player_variables.player_score)
	var random_powerups = POWER_UPS.duplicate()
	randomize()
	random_powerups.shuffle()
	for i in range(0, power_up_boxes.size()):
		var power_up = random_powerups[i]
		var power_up_box = power_up_boxes[i]
		power_up_box.init_powerup(power_up)
	PlayerVariables.player_score_updated.connect(on_score_updated)
	
func display_powerups():
	if !is_displaying_powerup:
		is_displaying_powerup = true
		var ui_elements_to_show = [title, score, %PowerUp, %PowerUp2, %PowerUp3, continue_button]
		fade_in_elements(0, ui_elements_to_show)

func fade_in_elements(elem_index: int, elems_to_fade: Array):
	if elem_index == elems_to_fade.size():
		is_finished_displaying_powerup = true
		return
	var tween = create_tween()
	var elem = elems_to_fade[elem_index]
	elem.global_position.y += 10
	tween.tween_property(elem, "modulate:a", 1, 0.5)
	tween.parallel().tween_property(elem, "global_position:y", elem.global_position.y - 10, 0.5)
	
	var callable = Callable(self, "fade_in_elements").bind(elem_index + 1, elems_to_fade)
	tween.finished.connect(callable)
		
func on_score_updated():
	score.text = "Infamy: " + str(_player_variables.player_score)

func on_continue():
	if is_finished_displaying_powerup:
		SceneTransition.change_scene_to_file("res://scenes/PreGameScene.tscn")
