extends Node

var current_round:int = 0
@export var spawn_points: Array[Node3D]
@export var clone_manager: Node3D
@export var player: CharacterBody3D
@export var objective_label: Label

signal round_started
signal round_won
signal round_failed

func _ready():
	start_round()

func _input(event):
	if event.is_action_pressed("win_game"):
		round_win()
	if event.is_action_pressed("lose_game"):
		end_round()

func start_round() -> void:
	player.controls_disabled = false
	if (current_round >= spawn_points.size()):
		current_round = 0
	player.global_transform = spawn_points[current_round].transform
	round_started.emit()
	clone_manager.start_new_track()
	clone_manager.spawn_clones()
	
func round_win() -> void:
	print("win!")
	current_round+=1
	round_won.emit()
	clone_manager.save_current()
	end_round()

func round_fail() -> void:
	print("lose...")
	round_failed.emit()
	end_round()

func end_round() -> void:
	clone_manager.delete_clones()
	player.controls_disabled = true
	$RoundStartTimer.start()
	

func _on_round_start_timer_timeout() -> void:
	start_round()
