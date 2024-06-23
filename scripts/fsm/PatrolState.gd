extends State

@onready var player: Player = get_node("/root/Main/Player")

const CHASE_DIST_THRESHOLD = 150
const WANDER_SPEED = 50

var _wandering := false
var _t := randf() * 4

func update(delta: float) -> void:
	var villager = entity as Villager
	var dist_to_player = villager.global_position.distance_to(player.global_position)
	if dist_to_player <= CHASE_DIST_THRESHOLD:
		villager._state_machine.transition_to("Chase")
	# Walk in a random direction
	else:
		_t -= delta
		if !_wandering and _t <= 0:
			_wandering = true
			villager.velocity = Vector2(randf() * 200 - 100, randf() * 200 - 100).normalized() * WANDER_SPEED
			sprite.flip_h = villager.velocity.x < 0
			_t = randf() * 2 + 1
			sprite.play("run")
		if _wandering and _t <= 0:
			_wandering = false
			villager.velocity = Vector2.ZERO
			_t = randf() * 4 + 2
			sprite.play("idle")
		villager.move_and_slide()

func enter(_msg:={}) -> void:
	var villager = entity as Villager
	villager.velocity = Vector2.ZERO
	sprite.play("idle")
