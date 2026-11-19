class_name SupplyBox
extends Area2D


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


@export var val: int = 1

signal collected(value: int)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Collected Supply Box")
		print("SB: Entered ", body.name)
		queue_free()

func kill() -> void:
	get_tree().paused = true
