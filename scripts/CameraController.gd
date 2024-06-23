extends Camera2D

#Based of the 3.x KidsCanCode implementation -> https://kidscancode.org/godot_recipes/3.x/2d/screen_shake/index.html

@export var decay := 0.9 # How quickly shaking will stop [0,1].
@export var max_offset := Vector2(100, 75) # Maximum displacement in pixels.
@export var max_roll := 0.1 # Maximum rotation in radians (use sparingly).

var noise_y = 0 # Value used to move through the noise

var trauma := 0.0 # Current shake strength
var trauma_pwr := 2 # Trauma exponent. Use [2,3]

func _ready():
	randomize()

func add_trauma(amount: float, max: float=1.0):
	trauma = min(trauma + amount, max)

func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
	# optional
	elif offset.x != 0 or offset.y != 0 or rotation != 0:
		lerp(offset.x, 0.0, 1)
		lerp(offset.y, 0.0, 1)
		lerp(rotation, 0.0, 1)

func shake():
	var amt = pow(trauma, trauma_pwr)
	noise_y += 1
	rotation = max_roll * amt * randf()
	offset.x = max_offset.x * amt * randf()
	offset.y = max_offset.y * amt * randf()
