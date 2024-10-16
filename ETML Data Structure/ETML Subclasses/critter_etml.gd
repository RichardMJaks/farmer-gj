class_name CritterETML
extends ExtendedTileMapLayer

var targeted_crops: Array[CropCell] = [] :
	get():
		targeted_crops = targeted_crops.filter(func(el): return el != null)
		return targeted_crops

		

func _set_cell_type() -> void:
	_cell_type = CritterCell


func target_crop(critter : Critter, crop : CropCell) -> Critter:
	targeted_crops.append(crop)
	return critter

func attack_crop(critter: Critter, crop: CropCell) -> CritterCell:
	var cell : CritterCell = _create_cell(crop.get_coords())
	cell.set_critter(critter)
	return cell
