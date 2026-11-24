extends Node

signal score_changed(total: int)

# Global score varible 
var score: int = 0
var characterClass: Player.CharacterClass


func add_score(amount: int) -> void:
	score += amount
	score_changed.emit(score)


func reset_score() -> void:
	score = 0
	score_changed.emit(score)
