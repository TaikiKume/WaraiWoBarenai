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

var isStartGame : bool =false

var count : int =0

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
		print("GameClear");
		return 1

#TimeOver判定
	progressTimer += delta;
	if(progressTimer>gameOverTime):
		get_tree().change_scene_to_file("res://game_over.tscn")
		print("TimeOver");


#プレイヤーの死亡判定をする
	if($Oni.global_transform.origin.length()<$Oni.room_burst_distance&&laughRadius>0.1):
		
		get_tree().change_scene_to_file("res://game_over.tscn")
		print("Die");	
	


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
