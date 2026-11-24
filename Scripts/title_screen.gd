extends Control

func _on_start_pressed() -> void:
	# Intialize Score
	Global.reset_score()
	
	# Load Level Scene
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
