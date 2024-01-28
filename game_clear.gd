extends Node2D

@export var restartBtn : Button;
@export var text : Label;
func _ready():
	if(Global.level >=1):
		text.text="GameClear"
		restartBtn.hide()
	pass



func _on_restart_button_pressed():
	$AudioStreamPlayer2.play()
	Global.level = 1
	get_tree().change_scene_to_file("res://main.tscn")


func _on_back_to_title_button_pressed():
	$AudioStreamPlayer2.play()
	Global.level = 0
	get_tree().change_scene_to_file("res://Title.tscn")
