extends Label

func set_start_round_text():
	text = "KILL"
	
func set_round_won_text():
	text = "AGAIN"
	
func set_round_failed_text():
	text = "FAILED"
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_round_manager_round_started() -> void:
	set_start_round_text()


func _on_round_manager_round_won() -> void:
	set_round_won_text()
	

func _on_round_manager_round_failed() -> void:
	set_round_failed_text()
