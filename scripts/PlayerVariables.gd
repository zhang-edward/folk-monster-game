extends Node

var player_score := 0
var generation_number = 0
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
