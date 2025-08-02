extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 8
@export var jump_speed = 5

var GRAVITY = ProjectSettings.get_setting("physics/3d/default_gravity")
var GRAVITY_DIR = ProjectSettings.get_setting("physics/3d/default_gravity_vector")

var LOOKAROUND_SPEED = 0.01

var rot_x = 0
var rot_y = 0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):  		
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion:
		rot_x += -event.relative.x * LOOKAROUND_SPEED
		rot_y += -event.relative.y * LOOKAROUND_SPEED
		transform.basis = Basis()
		rotate_object_local(Vector3.UP, rot_x)
		rotate_object_local(Vector3.RIGHT, rot_y)


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
