extends CanvasLayer

func change_scene_to_file(scene_file_path: String) -> void:
	"""
	Use this function to change scenes, which wraps get_tree().change_scene()
	with a fade in and fade out animation.
	
	Args:
		scene_file_path - file path to the .tscn scene file.
	"""
	$AnimationPlayer.play('dissolve')
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(scene_file_path)
	$AnimationPlayer.play_backwards('dissolve')
