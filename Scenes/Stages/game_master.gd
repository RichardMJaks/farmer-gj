extends Node

var money : int = 0
var soil_tml : SoilTileMapLayer 
var game_started : bool = false
var shop_tiles : Array[CellData] = []

var possible_seeds : Dictionary = {
	"wheat" : preload("res://Scenes/Plants/Seeds/wheat_seed.tscn"),
	"pumpkin" : preload("res://Scenes/Plants/Seeds/pumpkin_seed.tscn"),
	"tomato" : preload("res://Scenes/Plants/Seeds/tomato_seed.tscn"),
	"eggplant" : preload("res://Scenes/Plants/Seeds/eggplant_seed.tscn"),
}

func _process(delta: float) -> void:
	if not game_started:
		return
	
	

func _init_shop_tiles() -> void:
	for cell : CellData in soil_tml.grid_data.values():
		if cell.is_shop:
			shop_tiles.append(cell)

func init_game() -> void:
	money = 0
	game_started = true
	_init_shop_tiles()
