extends Node

var player_positions: Array[Transform3D]=[]
var player_aims: Array[Transform3D]=[]
var player_shots: Array[bool]=[]
var previous_plays_positions: Array[Array]=[]
var previous_shots: Array[Array] = []
var previous_aims: Array[Array] = []
var camera = null
@export var clone_scene: PackedScene
@export var player: CharacterBody3D

var clones: Array[CharacterBody3D] = []

func _input(event):  		
	if event.is_action_pressed("create_clone"):
		save_current()
		start_new_track()
	if event.is_action_pressed("spawn_clones"):
		spawn_clones()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = player.find_child("Camera3D")
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	player_positions.push_back(player.transform)
	player_shots.push_back(player.get_has_shot())
	if camera != null:
		player_aims.push_back(camera.transform)
	
func start_new_track() -> void:
	player_positions = []
	player_shots = []
	
func save_current() -> void:
	previous_plays_positions.push_front(player_positions)
	previous_shots.push_front(player_shots)
	previous_aims.push_front(player_aims)
	#print("created clone")
	
func spawn_clones() -> void:
	for i in previous_plays_positions.size():
		var clone = clone_scene.instantiate()
		clones.push_back(clone)
		clone.set_path(previous_plays_positions[i], previous_shots[i], previous_aims[i])
		get_tree().root.add_child(clone)
	#print("spawned clones")
	
func delete_clones() -> void:
	for clone in clones:
		clone.destroy()
	clones = []
