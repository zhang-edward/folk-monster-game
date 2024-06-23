extends State

@onready var player: Player = get_node("/root/Main/Player")

const FLEE_DIST_THRESHOLD = 150

func update(_delta: float) -> void:
	var villager = entity as Villager
	var dist_to_player = villager.global_position.distance_to(player.global_position)
	if dist_to_player <= FLEE_DIST_THRESHOLD:
		villager._state_machine.transition_to("Flee")

func enter(_msg:={}) -> void:
	sprite.play("idle")
