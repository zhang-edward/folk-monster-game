extends CPUParticles2D

var timer = 0

func _ready():
	pass

func _process(delta):
	timer += delta
	if timer >= 1:
		speed_scale = 0
