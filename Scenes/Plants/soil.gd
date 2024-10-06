class_name SoilTileMapLayer
extends TileMapLayer

var grid_data : Dictionary = {}

func _ready() -> void:
	GameMaster.soil_tml = self
	var cells = get_used_cells()
	for cell in cells:
		var cell_data = CellData.new()
		cell_data.coords = cell
		grid_data[cell] = cell_data
		if get_cell_atlas_coords(cell) == Vector2i(1, 2):
			cell_data.is_shop = true

func get_attackable_cells() -> Array[CellData]:
	var cell_datas = grid_data.values()
	var attackable_cells : Array[CellData] = []
	
	for cell : CellData in cell_datas:
		if cell.attackable():
			attackable_cells.append(cell)
	
	return attackable_cells;

func c_get_cell_data(coords : Vector2i) -> CellData:
	if not grid_data.has(coords):
		return null
	return grid_data[coords]

func plant(seed : Seed, data : CellData) -> void:
	if not data:
		return
	data.planted_crop = seed.seed_name
	
	var i_crop : Crop = seed.crop.instantiate()
	i_crop.cell_data = data
	i_crop.global_position = map_to_local(data.coords)
	data.crop = i_crop
	add_child(i_crop)
