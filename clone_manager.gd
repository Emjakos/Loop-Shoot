extends Node

var player_positions: Array[Transform3D]=[]
var previous_plays_positions: Array[Array]=[]
@export var clone_scene: PackedScene
@export var player: CharacterBody3D

var clones: Array[PackedScene] = []

func _input(event):  		
	if event.is_action_pressed("create_clone"):
		save_current()
		start_new_track()
	if event.is_action_pressed("spawn_clones"):
		spawn_clones()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	player_positions.push_back(player.transform)
	
func start_new_track() -> void:
	player_positions = []
	
func save_current() -> void:
	previous_plays_positions.push_front(player_positions)
	#print("created clone")
	
func spawn_clones() -> void:
	for play_pos in previous_plays_positions:
		var clone = clone_scene.instantiate()
		clones.push_back(clone)
		clone.set_path(play_pos)
		get_tree().root.add_child(clone)
	#print("spawned clones")
	
func delete_clones() -> void:
	for clone in clones:
		clone.queue_free()
	clones = []
