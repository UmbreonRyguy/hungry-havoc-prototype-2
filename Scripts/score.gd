extends CanvasLayer

@onready var score_text: RichTextLabel = $ScoreText

func _on_player_set_score(total: int) -> void:
	score_text.text = "Score: " + var_to_str(total)
