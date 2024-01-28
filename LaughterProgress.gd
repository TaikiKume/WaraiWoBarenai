extends ProgressBar


func _ready():
	pass # Replace with function body.


func _process(delta):
	var window_size = get_viewport_rect().size
	size.x = window_size.x*0.8
	size.y = window_size.y*0.05
	position.x = window_size.x*0.1
	position.y = window_size.y*0.1
	pass
