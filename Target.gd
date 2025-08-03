extends Node

@export var round_manager: Node3D
# Called when the node enters the scene tree for the first time.
func receive_bullet(from_player: bool) -> void:
	if (from_player):
		round_manager.round_win()
	else:
		round_manager.round_fail()
