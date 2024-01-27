extends Node
@export var progressbar: ProgressBar

@export var timerText : Label
@export var countDownText : Label
@export var timer : Timer
#笑い声の範囲
var laughRadius : float = 0.0
#笑いゲージ
var laughGagePoint : float = 0.0
#経過時間
var progressTimer : float = 0.0
#クリア時間
@export var gameOverTime : float = 60.0

var isStartGame : bool = false

var count : int =0

@export var Door : MeshInstance3D
@export var DoorLight : OmniLight3D
@export var DoorLight2 : OmniLight3D
@export var RoomLight : OmniLight3D

var DoorBroken : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!isStartGame):
		return 0
	
	progressbar.value = laughGagePoint
	print(laughGagePoint)
	
	timerText.text = str(int(gameOverTime - progressTimer));
#Clear!!!!
	if(laughGagePoint>=100):
		get_tree().change_scene_to_file("res://game_clear.tscn")
		return 1

#TimeOver判定
	progressTimer += delta;
	if(progressTimer>gameOverTime):
		get_tree().change_scene_to_file("res://game_over.tscn")


#プレイヤーの死亡判定をする
	if($Oni.global_transform.origin.length()<$Oni.room_burst_distance&&laughRadius>0.1):
		get_tree().change_scene_to_file("res://game_over.tscn")
		
	if laughRadius>0.1:
		RoomLight.light_energy += 1*delta
		RoomLight.light_color.h += delta
		RoomLight.light_color.s += delta
	else:
		RoomLight.light_energy = 1
		RoomLight.light_color.h = 0
		RoomLight.light_color.s = 0
		
		
	if($Oni.global_transform.origin.length()<$Oni.room_burst_distance*1.2&&not DoorBroken):
		DoorBroken = true
		Door.visible = false
		Door.get_child(0).playing=true
		DoorLight.light_energy =16
		DoorLight2.light_energy =16
		
	if($Oni.global_transform.origin.length()>$Oni.room_burst_distance*1.2&&DoorBroken):
		DoorBroken = false
		Door.visible = true
	
	if DoorLight.light_energy > 0:
		DoorLight.light_energy -= 10*delta
		DoorLight2.light_energy -= 10*delta
	else:
		DoorLight.light_energy = 0
		DoorLight2.light_energy = 0
	


#笑いゲージ減らす
func _addLaughGagePoint(addPoint):
	laughGagePoint += addPoint;
	laughGagePoint = clampf(laughGagePoint,0,100);

#笑い声を大きくする
func _addLaughRadius(addRadius):
	laughRadius+=addRadius;

#笑いを止める
func _resetLaughRadius():
	laughRadius = 0;
	
func _getisStartGame():
		return isStartGame;

func _on_timer_timeout():
	count+=1
	if(count<4):
		countDownText.text=str(3-count);
	else:
		timer.paused=true;
		countDownText.hide()
		isStartGame=true;
