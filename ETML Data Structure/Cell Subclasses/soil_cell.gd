class_name SoilCell
extends Cell

var _crop : Crop = null

func set_crop(crop : Crop) -> Crop:
	_crop = crop
	
	_crop.change_state(Crop.STATE_PLANTED)
	
	add_child(_crop)
	_crop.global_position = global_position
	
	return _crop
	
func get_crop() -> Crop:
	return _crop

func get_type():
	return "SoilCell"
