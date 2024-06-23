extends State

@onready var player = get_node("/root/Main/Player") as Player
const RUN_SPEED = 100
const CHASE_DIST_THRESHOLD = 250
const ATTACK_RANGE = 50

func update(_delta: float) -> void:
	var villager = entity as Villager
	var dist_to_player = villager.global_position.distance_to(player.global_position)
	if dist_to_player > CHASE_DIST_THRESHOLD:
		villager._state_machine.transition_to("Patrol")
	elif dist_to_player < ATTACK_RANGE:
		villager._state_machine.transition_to("Attack")
	else:
		var angle = villager.get_angle_to(player.global_position)
		var dir = Vector2.RIGHT.rotated(angle)
		if player.global_position.x < villager.global_position.x:
			sprite.flip_h = true
		else:
			sprite.flip_h = false

		villager.velocity = dir.normalized() * RUN_SPEED

	villager.move_and_slide()

func enter(_msg:={}) -> void:
	sprite.play("run")
