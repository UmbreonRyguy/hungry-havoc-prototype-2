class_name Bulletbox
extends Attackbox

@export var bullet_speed: float = 100
@export var lifetime: float = 10
var lifetime_timer: float = 0

func _physics_process(delta: float) -> void:
	position +=  Vector2.RIGHT.rotated(rotation) * bullet_speed * delta
	lifetime_timer += delta
	if lifetime_timer > lifetime: kill()


func _on_body_entered(_body: Node2D) -> void:
	kill()


func kill() -> void:
	queue_free()
