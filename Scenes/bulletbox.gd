class_name Bulletbox
extends Attackbox

@export var bullet_speed: float = 10


func _physics_process(delta: float) -> void:
	position +=  Vector2.RIGHT.rotated(rotation) * bullet_speed * delta


func _on_body_entered(_body: Node2D) -> void:
	kill()


func kill() -> void:
	queue_free()
