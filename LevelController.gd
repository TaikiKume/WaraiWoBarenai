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

signal game_startNotify

var DoorBroken : bool = false

var Onis : Array = []

func _ready():
	var current_difficulty = Global.difficulty
	print(current_difficulty)
	const Oni = preload("res://oni.tscn")

	var oni_instance = Oni.instantiate()
	oni_instance.speed = Global.difficulty_onis_level1[current_difficulty][0]
	oni_instance.alert_speed_mult = Global.difficulty_onis_level1[current_difficulty][1]
	oni_instance.stomping_sound_interval = Global.difficulty_onis_level1[current_difficulty][2]
	oni_instance.stomp_away_direction = Global.difficulty_onis_level1[current_difficulty][3]
	oni_instance.initial_distance = Global.difficulty_onis_level1[current_difficulty][4]
	oni_instance.relax_interval = Global.difficulty_onis_level1[current_difficulty][5]
	oni_instance.room_burst_distance = Global.difficulty_onis_level1[current_difficulty][6]
	oni_instance.max_distance = Global.difficulty_onis_level1[current_difficulty][7]
	add_child(oni_instance)
	Onis.append(oni_instance)
	pass

func _process(delta):
	if(!isStartGame):
		return 0
	
	progressbar.value = laughGagePoint
	print_debug(laughGagePoint)
	
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
	for oni in Onis:
		if(oni.global_transform.origin.length()<oni.room_burst_distance&&laughRadius>0.1):
			get_tree().change_scene_to_file("res://game_over.tscn")

		if laughRadius>0.1:
			if(RoomLight.light_energy<2):RoomLight.light_energy += 1*delta
			RoomLight.light_color.h += 0.1*delta
			RoomLight.light_color.s += delta
		else:
			RoomLight.light_energy = 1
			RoomLight.light_color.h = 0
			RoomLight.light_color.s = 0


		if(oni.global_transform.origin.length()<oni.room_burst_distance*1.2&&not DoorBroken):
			DoorBroken = true
			Door.visible = false
			Door.get_child(0).playing=true
			DoorLight.light_energy =16
			DoorLight2.light_energy =16

		if(oni.global_transform.origin.length()>oni.room_burst_distance*1.2&&DoorBroken):
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
		game_startNotify.emit()
