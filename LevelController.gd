extends Node
#笑い声の範囲
var laughRadius : float = 0.0
#笑いゲージ
var laughGagePoint : float = 0.0
#経過時間
var progressTimer : float =0.0
#クリア時間
@export var gameOverTime : float =60.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(laughGagePoint)
#Clear!!!!
	if(laughGagePoint>=100):
		print("GameClear");

#TimeOver判定
	progressTimer += delta;
	if(progressTimer>gameOverTime):
		print("TimeOver");


#プレイヤーの死亡判定をする
	if($Oni.global_transform.origin.length()<$Oni.room_burst_distance&&laughRadius>0.1):
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
