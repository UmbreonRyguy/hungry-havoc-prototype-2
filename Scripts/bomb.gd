class_name Bomb
extends RigidBody2D

@export var explosion_time: float = 4
@export var launch_speed: float = 300

func _ready() -> void:
	get_tree().create_timer(explosion_time).timeout.connect(explode)
	linear_velocity = Vector2.RIGHT.rotated(global_rotation) * launch_speed


func explode() -> void:
	print("EXPLODE")
