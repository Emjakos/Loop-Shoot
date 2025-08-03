extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 8
@export var jump_speed = 5
@export var lookaround_speed = 0.01
@export var max_rot_y = 0.75 * PI
@export var min_rot_y = -PI/2

var GRAVITY = ProjectSettings.get_setting("physics/3d/default_gravity")
var GRAVITY_DIR = ProjectSettings.get_setting("physics/3d/default_gravity_vector")

@export var bullet_scene: PackedScene
@export var bullet_speed = 20

var bullets: Array[Node3D] = []
var has_shot:bool = false

func _shoot():
	var main_scene = get_parent_node_3d()
	var bullet: RigidBody3D = bullet_scene.instantiate()
	bullets.push_back(bullet)
	bullet.from_player = true
	var camera = $Camera3D
	#var gun = camera.find_child("character_head").find_child("Cube_003")
	bullet.transform = camera.global_transform
	#bullet.position = gun.global_position
	bullet.translate_object_local(Vector3.FORWARD)
	bullet.apply_central_impulse(-bullet.transform.basis.z * bullet_speed)
	
	main_scene.add_child(bullet)
	has_shot = true


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


var rot_x = 0
var rot_y = 0

func _input(event):  		
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	if event.is_action_pressed("click") and Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("click") and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		_shoot()
		
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion:
		rot_x += -event.relative.x * lookaround_speed
		rot_y += -event.relative.y * lookaround_speed
		rot_y = clampf(rot_y, min_rot_y, max_rot_y)
		transform.basis = Basis()
		$Camera3D.basis = Basis()
		rotate_object_local(Vector3.UP, rot_x)
		$Camera3D.rotate_object_local(Vector3.RIGHT, rot_y)


func _physics_process(delta):
	velocity += GRAVITY_DIR * GRAVITY * delta
	
	var movement = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		movement += Vector3.RIGHT
	if Input.is_action_pressed("move_left"):
		movement += Vector3.LEFT
	if Input.is_action_pressed("move_back"):
		movement += Vector3.BACK
	if Input.is_action_pressed("move_forward"):
		movement += Vector3.FORWARD

	movement = movement.normalized() * speed
	movement = movement.rotated(Vector3.UP, rot_x)
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
	
	velocity.x = movement.x
	velocity.z = movement.z
	
	move_and_slide()
func get_has_shot() -> bool:
	var temp = has_shot
	has_shot = false
	return temp
func destroy_bullets() -> void:
	for bullet in bullets:
		if(bullet != null):
			bullet.destroy()
