extends State

@onready var player: Player = get_node("/root/Main/Player")

func update(_delta: float) -> void:
	var villager = entity as Villager
	var dist_to_player = villager.global_position.distance_to(player.global_position)
	if dist_to_player <= Villager.FLEE_DIST_THRESHOLD:
		villager._state_machine.transition_to("Flee")

func enter(_msg:={}) -> void:
	sprite.play("idle")
