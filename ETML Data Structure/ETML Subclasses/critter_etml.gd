class_name CritterETML
extends ExtendedTileMapLayer

func _set_cell_type() -> void:
	_cell_type = CritterCell

#TODO: Implement targeting
func target_crop(crop : CropCell, critter : Critter) -> CritterCell:
	var cell : CritterCell = _create_cell(crop.get_coords())
	cell.set_critter(critter, crop)
	return cell
