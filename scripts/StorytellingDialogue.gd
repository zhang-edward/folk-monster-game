extends Control

@onready var power_up_select = $"../../.." as PowerUpSelect

const INTRO_OPTIONS = [
	"Gather 'round, children. Long ago, a monstrous creature haunted our village at night.",
	"Come closer, little ones. In days of old, a terrifying beast prowled our village under the cover of darkness.",
	"Listen closely, young ones. In the past, a fearsome creature stalked our village after the sun set.",
	"Once upon a time, a monstrous creature terrorized our village after nightfall.",
	"Huddle near, kids. Ages past, a sinister beast with glowing eyes haunted our nights.",
	"Hear my tale, young ones. Once, a nightmarish beast roamed our village under the moon.",
	"Come, listen well, children. Long ago, a terrifying monster lurked in the shadows of our village."
]

const KILL_COUNT_OPTIONS = [
	"X souls were devoured by the beast on that fateful night.",
	"That fateful night, the beast claimed X lives.",
	"On that dreadful night, the beast took X souls.",
	"X lives were lost on that horrific night, taken by the beast.",
	"X souls fell to the beast on that tragic night.",
	"The beast stole X souls on that fateful night.",
	"X lives were taken by the beast on that grim night.",
	"That terrible night, the beast claimed X souls.",
	"On that fateful night, X souls were taken by the beast.",
	"X souls were consumed by the beast on that dreadful night.",
]

const POWERUP_OPTIONS = [
	"They say the beast could...",
	"It is whispered that the beast could...",
	"Legends tell that the beast had the power to...",
	"Some believe the beast was able to...",
	"Tales speak of the beast's ability to...",
	"They claim the beast could...",
	"Old stories say the beast was capable of...",
	"It is said the beast possessed the power to...",
	"Rumor has it the beast could...",
	"Folk tales describe how the beast could..."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var text = ""
	var score = (get_node("/root/PlayerVariables") as PlayerVariables).kill_count
	text += INTRO_OPTIONS[randi() % INTRO_OPTIONS.size()] + "\n\n"
	text += KILL_COUNT_OPTIONS[randi() % KILL_COUNT_OPTIONS.size()].replace("X", str(score)) + "\n\n"
	text += POWERUP_OPTIONS[randi() % POWERUP_OPTIONS.size()] + "\n\n"
	$DialogueBox.init(text)
	$DialogueBox.dialogue_finished.connect(on_dialogue_finished)
	
	
func on_dialogue_finished():
	power_up_select.display_powerups()
