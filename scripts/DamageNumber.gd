class_name DamageNumber
extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	self.z_index = 1000
	var fade_tween = create_tween()
	fade_tween.tween_property(self, "global_position", Vector2(global_position.x, global_position.y - 50), 1)
	fade_tween.parallel().tween_property(self, "modulate:a", 0, 1)
	fade_tween.finished.connect(_on_fade_complete)
	
func _on_fade_complete():
	queue_free()
