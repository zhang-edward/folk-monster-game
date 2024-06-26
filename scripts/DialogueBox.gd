class_name DialogueBox
extends RichTextLabel

signal dialogue_finished()

const SCROLL_INTERVAL = 0.01
const PUNCTUATION_INTERVAL = 0.5
const COMMA_INTERVAL = 0.1

var _scroll_interval := SCROLL_INTERVAL
var _t = 0
var _last_char = ""

@export var voice: AudioStreamPlayer2D
@export var skippable: bool = false
@onready var voice_timer: Timer = $VoiceTimer
var text_no_bb_code: String = ""
var done := false

# Called when the node enters the scene tree for the first time.
func init(txt: String):
	self.text = txt
	var regex = RegEx.new()
	regex.compile("\\[(.*?)\\]")
	text_no_bb_code = regex.sub(txt, "", true)
	print(text_no_bb_code)
	visible_characters = 0
	voice_timer.timeout.connect(voice_timer_timeout)
	voice_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if done:
		return

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and skippable:
		visible_characters = text.length()
		voice_timer.stop()
		dialogue_finished.emit()
		done = true
		return

	if _t > _scroll_interval:
		_t = 0
		if visible_characters < text_no_bb_code.length():
			visible_characters += 1
			_last_char = text_no_bb_code.substr(visible_characters - 1, 1)
			if _last_char == "." or _last_char == "\n":
				_scroll_interval = PUNCTUATION_INTERVAL
			elif _last_char == ",":
				_scroll_interval = COMMA_INTERVAL
			else:
				_scroll_interval = SCROLL_INTERVAL
	else:
		_t += delta
		if voice_timer.is_stopped():
			voice_timer.start()
	
	if visible_characters == text_no_bb_code.length():
		done = true
		voice_timer.stop()
		dialogue_finished.emit()

func voice_timer_timeout():
	if _last_char != "\n" and _last_char != "." and _last_char != ",":
		voice.play()
