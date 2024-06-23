extends Sprite2D
class_name Corpse

var _velocity
@onready var hit_sound: AudioStreamPlayer2D = $HitSound
@onready var death_sound: AudioStreamPlayer2D = $DeathSound

func init(pos: Vector2, velocity: Vector2, sprite: Texture2D):
	_velocity = velocity
	rotation_degrees = randf() * 360
	scale = Vector2(3, 3)
	position = pos
	texture = sprite
	hit_sound.play()
	if randf() < 0.3:
		death_sound.play()
	
func _process(delta):
	translate(_velocity * delta)
	_velocity *= 0.98
