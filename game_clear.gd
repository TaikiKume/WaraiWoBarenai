extends Node2D





func _on_restart_button_pressed():
	$AudioStreamPlayer2.play()
	get_tree().change_scene_to_file("res://main.tscn")


func _on_back_to_title_button_pressed():
	$AudioStreamPlayer2.play()
	get_tree().change_scene_to_file("res://Title.tscn")
