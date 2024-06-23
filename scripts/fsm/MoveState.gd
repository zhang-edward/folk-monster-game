extends State

func update(_delta: float) -> void:
	var player = entity as Player
	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_up", "move_down")
	var speed = player.calculate_attr_with_powerup(PlayerVariables.PowerUpTypes.SpeedUp, Player.BASE_SPEED, Player.SPEED_UPGRADE_INCREMENT)
	player.velocity = Vector2(direction_x, direction_y).normalized() * speed
	if direction_x < 0:
		sprite.flip_h = true
	elif direction_x > 0:
		sprite.flip_h = false
	player.move_and_slide()

	if player.velocity.x == 0 and player.velocity.y == 0:
		sprite.play("idle")
	else:
		sprite.play("walk")

func handle_input(input: InputEvent) -> void:
	if Input.is_action_just_pressed("attack"):
		state_machine.transition_to("MeleeAttack", {})
	if Input.is_action_just_pressed("lunge"):
		state_machine.transition_to("Lunge", {})

func enter(_msg:={}) -> void:
	pass
