class_name CropCell
extends Cell

var _crop : Crop = null

func set_crop(crop : Crop) -> Crop:
	_crop = crop
	return _crop
	
func get_crop() -> Crop:
	return _crop
	
func get_type():
	return "CropCell"
