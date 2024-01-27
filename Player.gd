extends Node3D
#笑い声の広がる速さ
@export var laughSpreadSpeed :float = 1.0

#笑い声ゲージの減る速さ
@export var laughPointSpeed : float=2.0

#声の大きさが上がる速さ
@export var addVolumeSpeed :float = 2.0
#ピッチの上がる速さ
@export var addPitchScaleSpeed : float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("Laugh")):
		$AudioStreamPlayer.play()
	if (Input.is_action_pressed("Laugh")):
			$AudioStreamPlayer.volume_db +=2*delta
			$AudioStreamPlayer.pitch_scale+=0.1*delta
			get_parent()._addLaughRadius(laughSpreadSpeed*delta)
			get_parent()._removeLaughGagePoint(-laughPointSpeed*delta)
	else:
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer.pitch_scale=1
		get_parent()._resetLaughRadius()

