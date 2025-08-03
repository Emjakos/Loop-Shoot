extends ProgressBar

@export var round_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	min_value = 0
	max_value = round_timer.wait_time
	value = (max_value - round_timer.time_left)
	$TimeLeftLabel.text = "%.2f" % round_timer.time_left
