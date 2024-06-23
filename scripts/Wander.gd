extends State

const IDLE_SPEED = 100

@onready var player: Player = get_node("/root/Main/Player")
var directions: Array[Vector2] = [
	Vector2(0, 1),
	Vector2(1, 0),
	Vector2(1, 1),
	Vector2(-1, 1),
	Vector2(0, -1),
	Vector2(-1, 0),
	Vector2(-1, -1),
]

var move_to_idle_timer: Timer
var rand_direction: Vector2

func update(_delta: float):
	var villager = entity as Villager
	var dist_to_player = villager.global_position.distance_to(player.global_position)
	if dist_to_player <= Villager.FLEE_DIST_THRESHOLD:
		villager._state_machine.transition_to("Flee")
	
	villager.velocity = rand_direction * IDLE_SPEED
	sprite.flip_h = villager.velocity.x < 0
	villager.move_and_slide()

func enter(msg:={}):
	move_to_idle_timer = Timer.new()
	move_to_idle_timer.autostart = true
	move_to_idle_timer.wait_time = randi_range(1.0, 2.0)
	move_to_idle_timer.one_shot = true
	var callable = Callable(self, "go_to_idle_state")
	move_to_idle_timer.connect("timeout", callable)
	add_sibling(move_to_idle_timer)
	rand_direction = directions.pick_random()
	
func exit():
	if move_to_idle_timer != null:
		move_to_idle_timer.stop()
		move_to_idle_timer.queue_free()
	
func go_to_idle_state():
	var villager = entity as Villager
	villager._state_machine.transition_to("Idle")
	
