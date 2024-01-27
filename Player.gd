extends Node3D
#笑い声の広がる速さ
@export var laughSpreadSpeed :float = 1.0

#笑い声ゲージの増える速さ
@export var laughPointSpeed : float=10.0

#声の大きさが上がる速さ
@export var addVolumeSpeed :float = 2.0
#ピッチの上がる速さ
@export var addPitchScaleSpeed : float = 0.1

var initialVolume : float
var pushTime : float = 0.0
var fliptimer : float = 0.0
var fliptimerlimit : float = 0.45

# Called when the node enters the scene tree for the first time.
func _ready():
	global_rotation = Vector3(0,0,0)
	initialVolume = $AudioStreamPlayer.volume_db
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!get_parent()._getisStartGame()):
				return 1;
	if(Input.is_action_just_pressed("Laugh")):   
		$AudioStreamPlayer.play()
	if (Input.is_action_pressed("Laugh")):
			global_rotation = Vector3(0,0,90)
			if(fliptimer<0):
				$GobotSkin.flip()
				fliptimer = fliptimerlimit
			else:
				fliptimer -= delta
			$AudioStreamPlayer.volume_db +=2*delta
			$AudioStreamPlayer.pitch_scale+=0.1*delta
			get_parent()._addLaughRadius(laughSpreadSpeed*delta)
			get_parent()._addLaughGagePoint((pushTime*0.5+laughPointSpeed)*delta)
			pushTime+=delta;
	else:
		global_rotation = Vector3(0,0,0)
		$GobotSkin.idle()
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer.volume_db = initialVolume
		$AudioStreamPlayer.pitch_scale=1
		pushTime=0.0
		get_parent()._resetLaughRadius()

