class_name LungeState
extends State

const SPEED = 1000.0
const LUNGE_DURATION = 0.2

var t := 0.0
var hitbox_scene: PackedScene = preload ("res://prefabs/Hitbox.tscn")

func update(delta: float) -> void:
	var player = entity as Player
	t += delta
	if t < LUNGE_DURATION:
		player.velocity = player.velocity.normalized() * SPEED
		player.move_and_slide()
	elif t > LUNGE_DURATION:
		sprite.play("attack_r1")
		player.attack("r", "1")
		state_machine.transition_to("Move")

func enter(_msg:={}) -> void:
	sprite.play("lunge")
	t = 0.0

	var hitbox = hitbox_scene.instantiate()
	entity.add_child(hitbox)
	hitbox.init(Vector2.ZERO, Vector2(100, 100), 0.25, Hitbox.CollideableTypes.Villager, randi() % 20 + 10)
