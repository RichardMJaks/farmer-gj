class_name CropCell
extends Cell

var _crop : Crop = null
var rotted : bool = false

func set_crop(crop : Crop) -> Crop:
	_crop = crop
	
	add_child(_crop)
	_crop.change_state(Crop.STATE_PLANTED)
	_crop.global_position = global_position
	_crop._cell = self
	
	return _crop

func harvest() -> int:
	#TODO: Add flair for when not possible to harvest
	if not _crop.harvestable:
		return 0
	
	#TODO: Add flair for when harvesting
	var crop_value = _crop.harvest()
	var earned_coins = GM.add_uncollected_coins(crop_value)
	GM.crops += 1
	GM.total_crops += 1
	
	#HACK: This probably can be solved better
	# Remove the reference for present plant and self
	_tml.erase_cell(_coords)
	call_deferred("queue_free")
	
	return earned_coins
	

func get_crop() -> Crop:
	return _crop
	
func get_type():
	return CropCell
