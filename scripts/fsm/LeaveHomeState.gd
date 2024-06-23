class_name LeaveHome
extends State

const IDLE_SPEED = 100
const CHASE_DIST_THRESHOLD = 250
var move_to_wander_timer: Timer
@onready var player: Player = get_node("/root/Main/Player")
# Only move down
var directions = [
	Vector2(0, 1),
	Vector2(1, 1),
	Vector2(-1, 1)
]

var rand_direction

func update(_delta: float):
	var villager = entity as Villager
	var dist_to_player = villager.global_position.distance_to(player.global_position)
	if dist_to_player <= CHASE_DIST_THRESHOLD:
		villager._state_machine.transition_to("Chase")
	
	villager.velocity = rand_direction.normalized() * IDLE_SPEED
	sprite.flip_h = villager.velocity.x < 0
	villager.move_and_slide()

func enter(msg:={}):
	move_to_wander_timer = Timer.new()
	move_to_wander_timer.autostart = true
	move_to_wander_timer.wait_time = 1.0
	move_to_wander_timer.one_shot = true
	var callable = Callable(self, "go_to_patrol_state")
	move_to_wander_timer.connect("timeout", callable)
	add_sibling(move_to_wander_timer)
	rand_direction = directions.pick_random()
	sprite.play("walk")
	
func exit():
	if move_to_wander_timer != null:
		move_to_wander_timer.stop()
		move_to_wander_timer.queue_free()
	
func go_to_patrol_state():
	var villager = entity as Villager
	villager._state_machine.transition_to("Wander")
