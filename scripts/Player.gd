class_name Player
extends CharacterBody2D

const SPEED = 300.0

var is_attacking = false

@onready var animated_sprite = $Sprite
@onready var effect = $Effect

func _ready():
	pass
	# animated_sprite.animation_finished.connect(on_attack_complete)
	# animated_sprite.frame_changed.connect(on_attack_frame)

func _physics_process(_delta):
	pass
		
func on_attack_complete():
	is_attacking = false

func _unhandled_input(_event):
	pass
	# if Input.is_action_just_pressed("attack"):
	# 	animated_sprite.play("attack")
	# 	is_attacking = true
