extends Node

var shop_etml : ShopETML
var sell_etml : SellETML
var critter_etml : CritterETML
var soil_etml : SoilETML
var crop_etml : CropETML

var crop : PackedScene = preload("res://Scenes/Crop/crop.tscn")

func _ready() -> void:
	call_deferred("init")

func init() -> void:
	var cells = shop_etml.cells.values()
	for cell : ShopCell in cells:
		var i_crop : Crop = crop.instantiate()
		cell.set_crop(i_crop)
