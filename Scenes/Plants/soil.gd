class_name SoilTileMapLayer
extends TileMapLayer

var grid_data : Dictionary = {}

func _ready() -> void:
	var cells = get_used_cells()
	for cell in cells:
		var cell_data = CellData.new()
		cell_data.coords = cell
		grid_data[cell] = cell_data
	print(grid_data)

func c_get_cell_data(coords : Vector2i) -> CellData:
	if not grid_data.has(coords):
		return null
	return grid_data[coords]

func plant(plant : String, data : TileData) -> void:
	print("planting " + plant)
	data.set_custom_data("plant", "rose")
