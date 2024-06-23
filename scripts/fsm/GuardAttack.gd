extends State

@export var ATTACK_FRAME = 4
@onready var _player_variables := get_node("/root/PlayerVariables") as PlayerVariables

const SPEED = 150.0
const GUARD_DAMAGE = 25
const GUARD_DAMAGE_INCR = 5
const ROUND_PER_GUARD_DAMAGE_INCR = 5
var hitbox_scene: PackedScene = preload ("res://prefabs/Hitbox.tscn")

func update(_delta: float) -> void:
	pass

func enter(_msg:={}) -> void:
	sprite.animation_finished.connect(on_attack_complete)
	sprite.frame_changed.connect(on_attack_frame)

	sprite.play("attack")
	sprite.pause()
	await get_tree().create_timer(0.5).timeout
	sprite.play("attack")

func exit() -> void:
	sprite.animation_finished.disconnect(on_attack_complete)
	sprite.frame_changed.disconnect(on_attack_frame)

func on_attack_frame():
	var villager = entity as Villager
	if sprite.frame != ATTACK_FRAME:
		return
	var effect_offset = Vector2( - 50, 0) if sprite.flip_h else Vector2(50, 0)
	villager.effect.position = effect_offset
	villager.effect.flip_h = sprite.flip_h
	villager.effect.show()
	villager.effect.play("stab")

	var hitbox = hitbox_scene.instantiate()
	villager.add_child(hitbox)
	var hitbox_offset = Vector2( - 50, 0) if sprite.flip_h else Vector2(50, 0)
	var guard_damage = calculate_guard_damage()
	hitbox.init(hitbox_offset, Vector2(50, 20), 0.1, Hitbox.CollideableTypes.Player, guard_damage)

func on_attack_complete():
	sprite.play("idle")
	# Cooldown before attacking again
	await get_tree().create_timer(0.5).timeout
	state_machine.transition_to("Chase")


func calculate_guard_damage():
	# Make villager health increase every few rounds
	return GUARD_DAMAGE + (int(_player_variables.generation_number) / int(ROUND_PER_GUARD_DAMAGE_INCR)) * GUARD_DAMAGE_INCR
