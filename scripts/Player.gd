class_name Player
extends CharacterBody2D

const SPEED = 300.0
var is_attacking = false
@onready var animated_sprite = $AnimatedSprite2D
@onready var effect = $Effect

func _physics_process(delta):
	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_up", "move_down")
	if direction_x:
		velocity.x = direction_x
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction_y:
		velocity.y = direction_y
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	# Normalized velocity (so that sprite doesn't move faster diagonally)
	if velocity.length() > 1:
		velocity = velocity.normalized()
		
	# Play animations
	if !is_attacking:
		if velocity.x == 0 and velocity.y == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("walk")
	
	if direction_x < 0:
		animated_sprite.flip_h = true
	elif direction_x > 0:
		animated_sprite.flip_h = false
		
	velocity = velocity * SPEED
	move_and_slide()
		
func on_attack_complete():
	is_attacking = false
	
func on_attack_frame():
	if animated_sprite.frame == 4 and is_attacking:
		var curr_position = animated_sprite.global_position
		effect.global_position = Vector2(curr_position.x - 50, curr_position.y + 10) \
			if animated_sprite.flip_h \
			else Vector2(curr_position.x + 50, curr_position.y + 10)
		effect.flip_h = animated_sprite.flip_h
		effect.show()
		effect.play("slash")


func _unhandled_input(event):
	if Input.is_action_just_pressed("attack"):
		animated_sprite.play("attack")
		is_attacking = true
		animated_sprite.animation_finished.connect(on_attack_complete)
		animated_sprite.frame_changed.connect(on_attack_frame)
