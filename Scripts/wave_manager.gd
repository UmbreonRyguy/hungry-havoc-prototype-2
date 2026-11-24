extends Node2D

#preload enemies for spawning
@export var enemy_scene: PackedScene = preload("res://Scenes/enemy.tscn")
@export var ranged_enemy_scene: PackedScene = preload("res://Scenes/enemy_ranged.tscn")

#spawn enemies unmder the enemy node
@export var enemies_parent: Node2D         

#how far enemies spawn from the players location
@export var spawn_distance: float = 200.0   

@export var wave_label: Label
	
var wave: int = 0
var enemies_left: int = 0

func _ready() -> void:
	start_next_wave()
	
func start_next_wave() -> void:
	wave += 1
	enemies_left = 2 + floor(wave * 1.5)
	update_wave_label()

	var player: Player = %"Player"

	var total_enemies: int = enemies_left
	
	#spawn each enemy
	for i in total_enemies:
		var scene: PackedScene = enemy_scene
		#every 3rd enemy is ranged
		if i % 3 == 0:
			scene = ranged_enemy_scene
			
		var enemy: Enemy = scene.instantiate()
		enemies_parent.add_child.call_deferred(enemy)
		#pick random angle around player to spawn enemy at
		var angle: float = randf() * TAU
		enemy.global_position = player.global_position + Vector2.from_angle(angle) * spawn_distance
		enemy.tree_exited.connect(_on_enemy_died)
	print("Wave ", wave, " - ", total_enemies, " enemies")

#count enemy deaths
func _on_enemy_died() -> void:
	enemies_left -= 1
	#when all dead start next wave
	if enemies_left <= 0:
		start_next_wave()
#update UI
func update_wave_label() -> void:
	if wave_label != null:
		wave_label.text = "Wave " + str(wave)
