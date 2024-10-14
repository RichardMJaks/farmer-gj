class_name CritterETML
extends ExtendedTileMapLayer

func _set_cell_type() -> void:
	_cell_type = CritterCell


func target_crop(crop : CropCell, critter : Critter) -> CritterCell:
	var cell : CritterCell = _create_cell(crop.get_coords())
	cell.set_critter(critter, crop)
	return cell

#TODO: Override get_cell() to return below plant if critter has not yet made it to the plant
