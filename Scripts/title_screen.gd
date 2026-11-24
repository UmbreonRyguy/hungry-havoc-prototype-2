extends Control

@onready var item_list: ItemList = $ItemList


func _ready() -> void:
	if !item_list.is_anything_selected():
		item_list.select(0)

func _on_start_pressed() -> void:
	# Intialize Score
	Global.reset_score()
	
	# Load Level Scene
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
