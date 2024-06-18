class_name Villager
extends RigidBody2D

@onready var _state_machine: StateMachine = get_node("StateMachine")
@onready var player: Player = get_node("/root/Main/Player") as Player
const FLEE_DIST_THRESHOLD = 200
