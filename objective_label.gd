extends Label

func set_start_round_text():
	text = "KILL THE\nTARGET"
	
func set_objective_complete_text():
	text = "GOOD"
	
func set_start_next_round_text():
	text = "AGAIN"
	
func set_failed_text():
	text = "FAILED\nTRY AGAIN"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
