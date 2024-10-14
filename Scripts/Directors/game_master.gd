extends Node

#region ETML Refs
var shop_etml : ShopETML
var sell_etml : SellETML
var critter_etml : CritterETML
var soil_etml : SoilETML
var crop_etml : CropETML
#endregion

var shop_mgr : Node2D

var crop : PackedScene = preload("res://Scenes/Crop/crop.tscn")

# Money vars
var coins : int = 0
var uncollected_coins = 0
var total_coins : int = 0
var crops : int = 0
var total_crops = 0

#TODO: When crop_pool[] is updated, update it in shop_mgr also
var crop_pool : Array[String] = [
	"wheat"
]

func _ready() -> void:
	call_deferred("init")

func init() -> void:
	var cells = shop_etml.cells.values()
	for cell : ShopCell in cells:
		var i_crop : Crop = crop.instantiate()
		cell.set_crop(i_crop)


func add_uncollected_coins(amount : int) -> int:
	uncollected_coins += amount
	return amount

#TODO: Collect coins flair
func collect_coins() -> int:
	add_coins(uncollected_coins)
	uncollected_coins = 0
	crops = 0
	return uncollected_coins

#TODO: Add coins flair
func add_coins(amount : int) -> int:
	coins += amount
	total_coins += amount
	return amount
	
#TODO: Remove coins flair
func remove_coins(amount : int) -> int:
	coins -= amount
	return amount
