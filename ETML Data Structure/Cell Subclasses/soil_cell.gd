class_name SoilCell
extends Cell

var _crop : Crop = null

func action(crop : Crop) -> int:
	if not _crop:
		set_crop(crop)
		return 0
	
	if not _crop._harvestable:
		#TODO: Add indicator of some kind of not being harvestable
		return 0
	
	_harvest()
	
	return 0

func set_crop(crop : Crop) -> Crop:
	if not crop:
		#TODO: Add indicator of not having anything to plant
		return null
	_crop = crop
	
	_crop.change_state(Crop.STATE_PLANTED)
	
	add_child(_crop)
	_crop.global_position = global_position
	
	return _crop

func _harvest() -> int:
	print_debug("harvesting")
	var crop_value = _crop.harvest()
	GM.add_coins(crop_value)
	return 0

func get_crop() -> Crop:
	return _crop

func get_type():
	return "SoilCell"
