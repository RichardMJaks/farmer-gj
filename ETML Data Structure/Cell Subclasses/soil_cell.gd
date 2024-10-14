class_name SoilCell
extends Cell

func plant(crop : Crop) -> Crop:
	GM.crop_etml.plant_crop(_coords, crop)
	return crop

func get_type():
	return "SoilCell"
