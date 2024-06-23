extends Node

var player_score := 0
var kill_count := 0
var generation_number = 1
var player_power_ups = []

# Power ups
enum PowerUpTypes {
	AcidSpit,
	FireBreath,
	AttackUp,
	DefenseUp,
	SpeedUp,
	TimeWarp,
	InfamyGain,
	AttackSpeed,
	LungeDamage,
}

var player_powerup_levels = {
	PowerUpTypes.AcidSpit: 0,
	PowerUpTypes.FireBreath: 0,
	PowerUpTypes.AttackUp: 0,
	PowerUpTypes.DefenseUp: 0,
	PowerUpTypes.SpeedUp: 0,
	PowerUpTypes.TimeWarp: 0,
	PowerUpTypes.InfamyGain: 0,
	PowerUpTypes.AttackSpeed: 0,
	PowerUpTypes.LungeDamage: 0,
}

signal player_score_updated

func update_player_score(new_player_score):
	player_score = new_player_score
	player_score_updated.emit()

func reset_player_powerup_level():
	for key in player_powerup_levels:
		player_powerup_levels[key] = 0
