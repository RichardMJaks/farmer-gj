class_name CritterETML
extends ExtendedTileMapLayer

func _set_cell_type() -> void:
	_cell_type = CritterCell

#TODO: Implement attacking
func attack_crop(coords : Vector2i, critter : Critter) -> CritterCell:
	return null
