extends Node2D

@export var mob_scene: PackedScene
@export var num_villagers = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var villagers = []
	for i in range(num_villagers):
		var villager = mob_scene.instantiate()
		villager.position = $Player.position
		villager.position.x += (i + 1) * 300
		villagers.append(villager)
		add_child(villager)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
