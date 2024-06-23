extends State

@export var ATTACK_FRAME = 4

const SPEED = 150.0

var hitbox_scene: PackedScene = preload ("res://prefabs/Hitbox.tscn")
var _attack_hand = ""
var _attack_number = ""

func update(_delta: float) -> void:
	var player = entity as Player
	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_up", "move_down")
	player.velocity = Vector2(direction_x, direction_y).normalized() * SPEED
	if direction_x < 0:
		sprite.flip_h = true
	elif direction_x > 0:
		sprite.flip_h = false
	player.move_and_slide()

func enter(msg:={}) -> void:
	_attack_hand = msg["last_attack_hand"] if msg.has("last_attack_hand") else null

	if _attack_hand == null:
		_attack_hand = "r" if randf() < 0.5 else "l"
	elif _attack_hand == "r":
		_attack_hand = "l"
	else:
		_attack_hand = "r"

	_attack_number = "1" if randf() < 0.5 else "2"
	var player = entity as Player
	var attack_speed = player.calculate_attr_with_powerup(PlayerVariables.PowerUpTypes.AttackSpeed, 1.0, 0.1)
	sprite.play("attack_" + _attack_hand + _attack_number, attack_speed)
	sprite.animation_finished.connect(on_attack_complete)
	sprite.frame_changed.connect(on_attack_frame)

func exit() -> void:
	sprite.animation_finished.disconnect(on_attack_complete)
	sprite.frame_changed.disconnect(on_attack_frame)

func on_attack_frame():
	if sprite.frame != ATTACK_FRAME:
		return

	var player = entity as Player
	player.attack(_attack_hand, _attack_number, false)

func on_attack_complete():
	if Input.is_action_pressed("attack"):
		state_machine.transition_to("MeleeAttack", {"last_attack_hand": _attack_hand})
	else:
		state_machine.transition_to("Move", {})
