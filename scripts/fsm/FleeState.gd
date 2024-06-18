extends State

@onready var player = get_node("/root/Main/Player") as Player
const RUN_SPEED = 250

func _physics_process(_delta: float) -> void:
	var villager = entity as Villager
	var dist_to_player = villager.global_position.distance_to(player.global_position)
	if dist_to_player > Villager.FLEE_DIST_THRESHOLD:
		villager._state_machine.transition_to("Idle")
	else:
		var angle = rad_to_deg(villager.get_angle_to(player.global_position))
		var opposite_angle = 0 if dist_to_player < 75 else -angle
		var dir = Vector2(cos(opposite_angle), sin(opposite_angle))
		if player.global_position.x > villager.global_position.x:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		
		villager.translate(dir * _delta * RUN_SPEED)

func enter(_msg:={}) -> void:
	sprite.play("run")
