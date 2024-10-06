extends Node

var money : int = 0
var soil_tml : SoilTileMapLayer 
var game_started : bool = false
var shop_tiles : Array[CellData] = []

var total_money : int = 0
var total_crops : int = 0

var seeds : Dictionary = {
	"wheat" : preload("res://Scenes/Plants/Seeds/wheat_seed.tscn"),
	"pumpkin" : preload("res://Scenes/Plants/Seeds/pumpkin_seed.tscn"),
	"tomato" : preload("res://Scenes/Plants/Seeds/tomato_seed.tscn"),
	"eggplant" : preload("res://Scenes/Plants/Seeds/eggplant_seed.tscn"),
}

var seed_selection : Array[String] = [
	"wheat"
]

var seed_prices : Dictionary = {
	"wheat" : 2,
	"pumpkin" : 3,
	"tomato" : 3,
	"eggplant" : 4
}

var crops : Dictionary = {
	"eggplant" : preload("res://Scenes/Plants/eggplant.tscn"),
	"wheat" : preload("res://Scenes/Plants/wheat.tscn"),
	"pumpkin" : preload("res://Scenes/Plants/pumpkin.tscn"),
	"tomato" : preload("res://Scenes/Plants/tomato.tscn")
}

func _process(delta: float) -> void:
	if not game_started:
		return

func _init_shop_tiles() -> void:
	for cell : CellData in soil_tml.grid_data.values():
		if cell.is_shop:
			shop_tiles.append(cell)
	
	for tile in shop_tiles:
		_add_seed_to_shop_cell(tile)

func _add_seed_to_shop_cell(cell_data : CellData):
	var seed_string : String = seed_selection.pick_random()
	cell_data.price = seed_prices[seed_string]
		
	var seed : Seed = _instantiate_display_seed(seed_string, cell_data)

func _instantiate_display_seed(seed : String, cell_data : CellData) -> Seed:
	var inst : Seed = seeds[seed].instantiate()
	inst.cell_data = cell_data
	cell_data.seed = inst
	soil_tml.add_child(inst)
	inst.global_position = soil_tml.map_to_local(cell_data.coords) + Vector2(0, -4)
	
	return inst

func add_money(amount : int) -> void:
	money += amount
	total_money += amount

func remove_money(amount : int) -> void:
	money -= money
	
func show_money_change(amount : int) -> void:
	pass

func init_game() -> void:
	money = 5
	total_money = 0
	total_crops = 0
	game_started = true
	_init_shop_tiles()
