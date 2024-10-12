class_name CropETML
extends ExtendedTileMapLayer

func _set_cell_type() -> void:
	_cell_type = CropCell
	
#TODO: Implement plant_crop()
func plant_crop(coords : Vector2i, crop : Crop) -> CropCell:
	return null
