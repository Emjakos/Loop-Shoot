extends CharacterBody3D
var path: Array[Transform3D] = []
var shots: Array[bool] = []
var path_index: int = 0
@export var bullet_scene: PackedScene
@export var bullet_speed = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (!path.is_empty() && path_index<path.size()):
		global_transform = path[path_index]
		if (shots[path_index]):
			_shoot()
		path_index+=1

func set_path(new_path: Array[Transform3D], new_shots: Array[bool]) -> void:
	path = new_path
	shots = new_shots
func destroy() -> void:
	queue_free()

func _shoot():
	var main_scene = get_tree().get_root()
	var bullet: RigidBody3D = bullet_scene.instantiate()
	var camera = $Camera3D
	bullet.transform = camera.global_transform
	bullet.translate_object_local(Vector3.FORWARD)
	bullet.apply_central_impulse((bullet.position - camera.global_position).normalized() * bullet_speed)
	
	main_scene.add_child(bullet)
