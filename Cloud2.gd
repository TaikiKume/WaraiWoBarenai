extends MeshInstance3D

var initPos : Vector3;
# Called when the node enters the scene tree for the first time.
func _ready():
	initPos = global_transform.origin;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_transform.origin.x-=delta;
	if(transform.origin.x<-20):
		global_transform.origin = Vector3(5,initPos.y,initPos.z) 
	pass
