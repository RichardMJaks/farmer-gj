class_name CropETML
extends ExtendedTileMapLayer

func _set_cell_type() -> void:
	_cell_type = CropCell
	

func plant_crop(coords : Vector2i, crop : Crop) -> Crop:
	var cell = _create_cell(coords)
	cell.set_crop(crop)
	return crop
