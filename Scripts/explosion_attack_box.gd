class_name ExplosionAttackbox
extends Attackbox

func explode() -> void:
	var areas: Array[Area2D] = get_overlapping_areas()
	for a in areas:
		a.area_entered.emit(self)
			
