extends Node2D
@export var radioButton : CheckBox
# Called when the node enters the scene tree for the first time.

func _ready():
	Global.level = 0
	radioButton.button_pressed=true

func _on_restart_button_pressed():
	$AudioStreamPlayer2.play()
	get_tree().change_scene_to_file("res://main.tscn")


func _on_check_box_toggled(toggled_on):
	if toggled_on:
		$AudioStreamPlayer2.play()
		Global.difficulty=0;



func _on_check_box_2_toggled(toggled_on):
	if toggled_on:
		$AudioStreamPlayer2.play()
		Global.difficulty=1;


func _on_check_box_3_toggled(toggled_on):
	if toggled_on:
		$AudioStreamPlayer2.play()
		Global.difficulty=2;
