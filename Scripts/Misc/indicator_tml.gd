extends TileMapLayer

@onready var critter_etml : CritterETML = $"../CritterETML"
@onready var crop_etml : CropETML = $"../CropETML"
@onready var sell_etml : SellETML = $"../SellETML"
@onready var shop_etml : ShopETML = $"../ShopETML"
@onready var soil_etml : SoilETML = $"../SoilETML"

@onready var etmls : Array[ExtendedTileMapLayer] = [
	critter_etml,  
	sell_etml, 
	shop_etml,
	crop_etml, 
	soil_etml
]


func _ready() -> void:
	_check_for_missing_dependencies()
	
	var player = get_tree().current_scene.get_node("Player")
	if player:
		player.indicator_tml = self
	else:
		push_error("Player not found!")

func _check_for_missing_dependencies() -> int:
	var status = 0
	if not critter_etml:
		push_error("CritterETML is missing!")
		status = -1
	if not sell_etml:
		push_error("SellETML is missing!")
		status = -1
	if not shop_etml:
		push_error("ShopETML is missing!")
		status = -1
	if not crop_etml:
		push_error("CropETML is missing!")
		status = -1
	if not soil_etml:
		push_error("SoilETML is missing!")
		status = -1
	
	return status

func get_cell(coords : Vector2i) -> Cell:
	var cell = null
	for etml in etmls:
		if not etml:
			push_error("Missing ETML!")
			continue
		
		cell = etml.get_cell(coords)
		if cell:
			set_indicator(coords)
			return cell
	
	_unset_indicator()
	return null


func set_indicator(coords : Vector2i) -> Vector2i:
	_unset_indicator()
	set_cell(coords, 0, Vector2i.ZERO)
	return coords


func _unset_indicator() -> int:
	var cells = get_used_cells()
	if not cells:
		return 0
	for cell in get_used_cells():
		erase_cell(cell)
	return 1
