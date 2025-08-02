extends Node

var player_positions: Array[Transform3D]=[]
var previous_plays_positions: Array[Array]=[]
@export var clone_scene: PackedScene

func _input(event):  		
	if event.is_action_pressed("create_clone"):
		saveCurrent()
	if event.is_action_pressed("spawn_clones"):
		spawnClones()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_positions.push_back($Player.transform)
	
func saveCurrent() -> void:
	previous_plays_positions.push_front(player_positions)
	player_positions = []
	print("created clone")
	
func spawnClones() -> void:
	for play_pos in previous_plays_positions:
		var clone = clone_scene.instantiate()
		clone.set_path(play_pos)
		add_child(clone)
	print("spawned clones")
