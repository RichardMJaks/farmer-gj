extends Node2D

var crops_for_sale : Dictionary = {}

#TODO: Test set_crop()
func set_crop(coords : Vector2i, crop : Crop) -> Crop:
	
	
	crops_for_sale[coords] = crop
	
	return crop
