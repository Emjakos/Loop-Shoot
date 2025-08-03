extends RigidBody3D
var from_player: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _on_body_entered(body:Node):
	print("Collided with: ", body.name)
	if (body.name == "Target"):
		body.receive_bullet(from_player)
	if (!body.name.begins_with("bullet")):
		destroy()
func destroy():
	queue_free()
