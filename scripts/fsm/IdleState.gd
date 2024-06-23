extends State

@onready var player: Player = get_node("/root/Main/Player")

var move_to_wander_timer: Timer

func update(_delta: float) -> void:
	var villager = entity as Villager
	var dist_to_player = villager.global_position.distance_to(player.global_position)
	if dist_to_player <= Villager.FLEE_DIST_THRESHOLD:
		villager._state_machine.transition_to("Flee")

func enter(_msg:={}) -> void:
	move_to_wander_timer = Timer.new()
	move_to_wander_timer.autostart = true
	move_to_wander_timer.one_shot = true
	move_to_wander_timer.wait_time = randi_range(1.0, 2.0)
	var callable = Callable(self, "go_to_wander_state")
	move_to_wander_timer.connect("timeout", callable)
	add_sibling(move_to_wander_timer)
	sprite.play("idle")
	
func go_to_wander_state():
	var villager = entity as Villager
	villager._state_machine.transition_to("Wander")

func exit() -> void:
	if move_to_wander_timer != null:
		move_to_wander_timer.stop()
		move_to_wander_timer.queue_free()
