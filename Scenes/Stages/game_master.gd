extends Node

var money : int = 0
var soil_tml : SoilTileMapLayer 
var game_started : bool = false
var shop_tiles : Array[CellData] = []

var total_money : int = 0
var total_crops : int = 0

var money_time_multiplier : float = 0.165

var money_change_label : PackedScene = preload("res://Scenes/GUI/money_change_label.tscn")

var HUD : CanvasLayer

var total_time : float = 0
var remaining_time : float = 60

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
		
	total_time += delta
	remaining_time -= delta

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
	remaining_time *= 1 + amount * money_time_multiplier
	show_money_change(amount)

func remove_money(amount : int) -> void:
	money -= amount
	show_money_change(-amount)
	
func show_money_change(amount : int) -> void:
	var inst : Label = money_change_label.instantiate()
	inst.text = ("+" if amount > 0 else "") + str(amount)
	inst.position = Vector2(105, 65)
	HUD.add_child(inst)
	

func init_game() -> void:
	money = 5
	total_money = 0
	total_crops = 0
	game_started = true
	_init_shop_tiles()
