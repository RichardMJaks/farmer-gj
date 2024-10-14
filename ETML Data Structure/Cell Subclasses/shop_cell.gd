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
	
	
	#FIXME: Probably not required, keeping it in just in case
	if not _crop:
		return null
	
	var crop = _crop
	
	
	#TODO: Flair for not enough money
	if crop.price > GM.coins:
		return null
	GM.remove_coins(crop.price)
	
	crop.change_state(Crop.STATE_CARRIED)
	remove_child(crop)
	
	_crop = null
	
	bought_crop.emit(self)
	return crop

func get_type():
	return ShopCell
