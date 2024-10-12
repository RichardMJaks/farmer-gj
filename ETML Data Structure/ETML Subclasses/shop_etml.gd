class_name ShopETML
extends ExtendedTileMapLayer

func _set_cell_type() -> void:
	_cell_type = ShopCell
	
#TODO: Implement set_crop()
func set_crop(coords : Vector2i, crop : Crop) -> ShopCell:
	return null
	
#TODO: Implement buy_crop()
func buy_crop(coords : Vector2i) -> Crop:
	return null
	
