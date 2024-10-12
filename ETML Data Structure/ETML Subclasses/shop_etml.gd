class_name ShopETML
extends ExtendedTileMapLayer

func _set_cell_type() -> void:
	_cell_type = ShopCell
	
#TODO: Implement set_crop()
func set_crop(coords : Vector2i, crop : Crop) -> ShopCell:
	if not crop:
		push_error("No crop!")
		return null
	
	var cell : ShopCell = cells[coords]
	cell.set_crop(crop)
	
	add_child(crop)
	crop.global_position = owner.map_to_local(coords)
	
	return cell
	
