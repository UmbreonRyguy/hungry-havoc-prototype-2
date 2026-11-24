extends CanvasLayer

@onready var crates_collected_text: RichTextLabel = $CratesCollectedText

func _on_crate_collected(total: int) -> void:
	crates_collected_text.text = var_to_str(total) + "/5"
