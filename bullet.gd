extends RigidBody3D
var from_player: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func is_from_player() -> bool:
	return from_player
	
func _on_body_entered(body:Node):
	print("Collided with: ", body.name)
	if (body.has_method("receive_bullet")):
		body.receive_bullet(from_player)
	if (!body.has_method("is_from_player")):
		destroy()
func destroy():
	queue_free()
