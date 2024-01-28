extends Node2D


# Called when the node enters the scene tree for the first time.



func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_check_box_toggled(toggled_on):
	if toggled_on:
		Global.difficulty=0;


func _on_check_box_2_toggled(toggled_on):
		Global.difficulty=1;


func _on_check_box_3_toggled(toggled_on):
		Global.difficulty=2;
