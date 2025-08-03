extends CharacterBody3D
var path: Array[Transform3D] = []
var shots: Array[bool] = []
var aims: Array[Transform3D] = []
var path_index: int = 0
var bullets: Array[Node3D] = []
@export var bullet_scene: PackedScene
@export var bullet_speed = 20
var slow_multiplier: int
var process_index_tracker: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (process_index_tracker <= 1):
		if (!path.is_empty() && path_index<path.size()):
			global_transform = path[path_index]
			$Camera3D.transform = aims[path_index]
			if (shots[path_index]):
				_shoot()
			path_index+=1
		process_index_tracker = slow_multiplier
	else:
		process_index_tracker -= 1

func set_path(new_path: Array[Transform3D], new_shots: Array[bool], new_aims: Array[Transform3D]) -> void:
	path = new_path
	shots = new_shots
	aims = new_aims
	
func set_order(n: int):
	#slow_multiplier = 2 ** n
	slow_multiplier = 1
	
func receive_bullet(from_player):
	destroy()
	
func destroy() -> void:
	for bullet in bullets:
		if (bullet != null):
			bullet.destroy()
	queue_free()

func _shoot():
	var main_scene = get_tree().get_root()
	var bullet: RigidBody3D = bullet_scene.instantiate()
	bullets.push_back(bullet)
	var camera = $Camera3D
	#var gun = camera.find_child("character_head").find_child("Cube_003")
	bullet.transform = camera.global_transform
	#bullet.position = gun.global_position
	bullet.translate_object_local(Vector3.FORWARD)
	bullet.apply_central_impulse(-bullet.transform.basis.z * bullet_speed / slow_multiplier)
	
	main_scene.add_child(bullet)
