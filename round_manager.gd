extends Node

var current_round:int = 0
@export var spawn_points: Array[Node3D]
@export var clone_manager: Node3D
@export var player: CharacterBody3D

func _input(event):
	if event.is_action_pressed("win_game"):
		round_win()
	if event.is_action_pressed("lose_game"):
		end_round()

func start_round() -> void:
	if (current_round >= spawn_points.size()):
		current_round = 0
	player.global_transform = spawn_points[current_round].transform
	clone_manager.start_new_track()
	clone_manager.spawn_clones()
	
func round_win() -> void:
	print("win!")
	current_round+=1
	clone_manager.save_current()
	end_round()

func round_fail() -> void:
	print("lose...")
	end_round()

func end_round() -> void:
	clone_manager.delete_clones()
	start_round()
