class_name Player
extends CharacterBody2D

@export var speed: float = 80
## Bullets per second
@export var firing_speed: float = 2.5
@export var knockback_strength: float = 120
@export var knockback_damping: float = 240

@onready var health_component: HealthComponent = $HealthComponent
@onready var bullet_spawn_point: Node2D = $BulletSpawnPoint

var pizza_scene: PackedScene = preload("res://Scenes/pizza_projectile.tscn")

var input_vector: Vector2 = Vector2.ZERO
var knockback_vector: Vector2 = Vector2.ZERO
var firing_cooldown: float = 0
var cratesCollected = 0


func _process(delta: float) -> void:
	firing_cooldown -= delta
	
	if firing_cooldown <= 0 && Input.is_action_pressed("Attack"):
		attack()
		# Reset cooldown
		firing_cooldown = 1 / firing_speed


func attack() -> void:
	var pizza: Area2D = pizza_scene.instantiate()
	pizza.global_transform = bullet_spawn_point.global_transform
	add_sibling(pizza)


func _physics_process(delta: float) -> void:
	movement_input()
	rotate_with_movement()
	apply_knockback(delta)
	move_and_slide()


func movement_input() -> void:
	# Get movement input
	input_vector.x = Input.get_axis("Move Left", "Move Right")
	input_vector.y = Input.get_axis("Move Up", "Move Down")
	input_vector = input_vector.normalized()
	
	# Set velocity
	velocity = input_vector * speed


func rotate_with_movement() -> void:
	look_at(position + input_vector* 100)


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
	print("PLAYER: ", health)
	# Trigger knockback using collision angle
	var angle: float = global_position.angle_to_point(area.global_position)
	knockback_vector = Vector2.from_angle(angle) * -knockback_strength
	
	if health <= 0:
		kill()

func kill() -> void:
	get_tree().paused = true

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("crate"):
		area.queue_free()
		cratesCollected += 1
		print(cratesCollected)
