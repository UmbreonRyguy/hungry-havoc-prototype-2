extends Control

@onready var item_list: ItemList = $ItemList


func _ready() -> void:
	if !item_list.is_anything_selected():
		item_list.select(0)

func _on_start_pressed() -> void:
	# Intialize Score
	Global.reset_score()
	
	# Set player class
	if item_list.is_selected(0):
		Global.characterClass = Player.CharacterClass.MELEE
	if item_list.is_selected(1):
		Global.characterClass = Player.CharacterClass.RANGED
	if item_list.is_selected(2):
		Global.characterClass = Player.CharacterClass.BOMBER
	
	# Load Level Scene
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
