extends CanvasLayer

@onready var score_text: Label = $ScoreText

func _ready() -> void:
	Global.score_changed.connect(_on_score_changed)
	_on_score_changed(Global.score)


func _on_score_changed(total: int) -> void:
	score_text.text = "Score: " + str(total)
