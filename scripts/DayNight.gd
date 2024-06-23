extends CanvasModulate

var START_COLOR = Color.hex(0x2c2b66FF)
var END_COLOR = Color.hex(0xD98027FF)

var main_node: Main

# Called when the node enters the scene tree for the first time.
func _ready():
	main_node = get_parent()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var t = (Main.TIME_LIMIT_SECONDS - main_node.time_remaining) / Main.TIME_LIMIT_SECONDS
	color = START_COLOR.lerp(END_COLOR, pow(t, 4))
