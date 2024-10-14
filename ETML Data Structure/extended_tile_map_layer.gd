class_name ExtendedTileMapLayer
extends TileMapLayer

var cells : Dictionary = {}

# Override this to change created cell type
var _cell_type = Cell

func _ready() -> void:
	_set_cell_type()
	_add_to_gm()
	
	# Add cells to this custom data type
	var used_cells = get_used_cells()
	for cell_coords in used_cells:
		_create_cell(cell_coords)

func _create_cell(coords : Vector2i) -> Cell:
	var cell : Cell = _cell_type.new()
	cell._tml = self
	cell.set_coords(coords)
	cells[coords] = cell
	add_child(cell)
	cell.global_position = map_to_local(coords)
	return cell


#HACK: We use this function because you cannot change parent class vars in inheriting classes
func _set_cell_type() -> void:
	_cell_type = Cell
	
func _add_to_gm() -> void:
	match(_cell_type):
		ShopCell:
			GM.shop_etml = self
		SellCell:
			GM.sell_etml = self
		CritterCell:
			GM.critter_etml = self
		SoilCell:
			GM.soil_etml = self
		CropCell:
			GM.crop_etml = self
	
func get_cell(cell_coords : Vector2i) -> Cell:
	if not cells.keys().has(cell_coords):
		return null
	
	var cell = cells[cell_coords]
	
	#HACK: Currently need to check instance validity due to freeing cell for crop and critter tml-s
	return cell if is_instance_valid(cell) else null
