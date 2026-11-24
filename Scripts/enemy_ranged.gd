class_name EnemyRanged
extends Enemy

@export var fire_rate: float = 2.5
@onready var bullet_spawn_point: Node2D = $BulletSpawnPoint
var fork_scene: PackedScene = preload("res://Scenes/enemy_fork.tscn")
var shoot_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shoot_timer = Timer.new()
	shoot_timer.wait_time = fire_rate #.wait_time countdown in secs
	shoot_timer.autostart = true #.autostart upon enter ST
	shoot_timer.timeout.connect(attack) #.timeout signal emit when wait_time finnish
	add_child(shoot_timer)

func attack() -> void:
	var fork = fork_scene.instantiate()
	fork.global_transform = bullet_spawn_point.global_transform
	add_sibling(fork)
