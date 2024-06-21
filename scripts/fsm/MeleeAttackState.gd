extends State

@export var ATTACK_FRAME = 4

const SPEED = 150.0

var hitbox_scene: PackedScene = preload ("res://prefabs/Hitbox.tscn")

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

func enter(_msg:={}) -> void:
	sprite.play("attack")
	sprite.animation_finished.connect(on_attack_complete)
	sprite.frame_changed.connect(on_attack_frame)

func exit() -> void:
	sprite.animation_finished.disconnect(on_attack_complete)
	sprite.frame_changed.disconnect(on_attack_frame)

func on_attack_frame():
	if sprite.frame != 4:
		return

	var player = entity as Player
	var effect_offset = Vector2( - 50, 0) if sprite.flip_h else Vector2(50, 0)
	player.effect.position = effect_offset
	player.effect.flip_h = sprite.flip_h
	player.effect.show()
	player.effect.play("slash")

	var hitbox = hitbox_scene.instantiate()
	player.add_child(hitbox)
	var hitbox_offset = Vector2( - 50, 0) if sprite.flip_h else Vector2(50, 0)
	hitbox.init(hitbox_offset, Vector2(100, 100), 0.25, Hitbox.CollideableTypes.Villager)

func on_attack_complete():
	state_machine.transition_to("Move", {})
