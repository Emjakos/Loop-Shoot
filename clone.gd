extends CharacterBody3D
var path: Array[Transform3D] = []
var path_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!path.is_empty() && path_index<path.size()):
		global_transform = path[path_index]
		path_index+=1
		print(path_index)

func set_path(new_path: Array[Transform3D]) -> void:
	path = new_path
	print("path received")
