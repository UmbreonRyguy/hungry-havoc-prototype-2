class_name Enemy
extends CharacterBody2D

@onready var player: Player = %"Player"
@onready var sprite: Sprite2D = $Sprite2D


@export var speed: float = 20
@export var knockback_strength: float = 120
@export var knockback_damping: float = 240

var knockback_vector: Vector2 = Vector2.ZERO


func _process(_delta: float) -> void:
	sprite.global_rotation = 0


func _physics_process(delta: float) -> void:
	look_at(player.global_position)
	set_movement()
	apply_knockback(delta)
	move_and_slide()


func set_movement() -> void:
	var angle: float = global_position.angle_to_point(player.global_position)
	velocity = Vector2.from_angle(angle) * speed


func apply_knockback(delta: float) -> void:
	# Apply knockback
	if knockback_vector.length() > 0.01:
		# Add knockback velocity
		velocity += knockback_vector
		# Dampen Knockback
		var new_len: float = knockback_vector.length() - knockback_damping * delta
		if new_len <= 0: new_len = 0
		knockback_vector = knockback_vector.limit_length(new_len)


func _on_damage_taken(_damage: int, health: int, area: Area2D) -> void:
	print("ENEMY: ", health)
	
	# Trigger knockback using collision angle
	var angle: float = global_position.angle_to_point(area.global_position)
	knockback_vector = Vector2.from_angle(angle) * -knockback_strength
	
	if health <= 0:
		kill()


func kill() -> void:
	queue_free()
