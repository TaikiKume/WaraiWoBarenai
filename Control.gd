extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var window_size = get_viewport_rect().size
	size.x = window_size.x
	size.y = window_size.y
	position.x = 0 
	position.y = 0
	pass
