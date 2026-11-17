class_name Crate extends Area2D
var cratesCollected = 0



func _on_body_entered(body: Node2D) -> void:
	queue_free()
	cratesCollected += 1
	print("Crates Collected: " + str(cratesCollected))
