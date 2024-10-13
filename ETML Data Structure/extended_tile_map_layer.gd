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
		var cell : Cell = _cell_type.new()
		cell.set_coords(cell_coords)
		cells[cell_coords] = cell
		add_child(cell)
		cell.position = map_to_local(cell_coords)
	

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
	return cells[cell_coords]
