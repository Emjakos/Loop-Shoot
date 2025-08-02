extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

var LOOKAROUND_SPEED = 0.01
var camera_anglev = 0

var target_velocity = Vector3.ZERO

var rot_x = 0
var rot_y = 0

func _input(event):  		
	if event is InputEventMouseMotion:
		rot_x += -event.relative.x * LOOKAROUND_SPEED
		rot_y += -event.relative.y * LOOKAROUND_SPEED
		transform.basis = Basis()
		rotate_object_local(Vector3.UP, rot_x)
		rotate_object_local(Vector3.RIGHT, rot_y)


func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		# Setting the basis property will affect the rotation of the node.
		# $Pivot.basis = Basis.looking_at(direction)

	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
