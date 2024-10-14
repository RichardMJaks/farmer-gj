class_name ShopCell
extends Cell

var _crop : Crop = null

# Great to 
signal bought_crop(cell : ShopCell)

#TODO: Flair for spawning crop into shop
func set_crop(crop : Crop) -> Crop:
	_crop = crop
	add_child(_crop)
	
	_crop.change_state(Crop.STATE_BUYABLE)
	
	_crop.global_position = global_position
	
	return _crop
	
func get_crop() -> Crop:
	return _crop

func buy_crop() -> Crop:
	if not _crop:
		print_debug("Trying to buy non-existent crop at " + str(_coords))
		return null
	
	var crop = _crop
	
	#TODO: Implement prices
	
	crop.change_state(Crop.STATE_CARRIED)
	remove_child(crop)
	
	_crop = null
	
	bought_crop.emit(self)
	
	var fstring = "Bought %s at %s for %d"
	print_debug(fstring % [crop, _coords, crop.price])
	
	return crop

func get_type():
	return ShopCell
