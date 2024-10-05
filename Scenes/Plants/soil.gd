class_name SoilTileMapLayer
extends TileMapLayer

var grid_data : Dictionary = {}
@onready var crops : Dictionary = {
	"eggplant" : preload("res://Scenes/Plants/eggplant.tscn")
}

func _ready() -> void:
	var cells = get_used_cells()
	for cell in cells:
		var cell_data = CellData.new()
		cell_data.coords = cell
		grid_data[cell] = cell_data
	print(grid_data)

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

func plant(crop : String, data : CellData) -> void:
	var l_crop : PackedScene = crops[crop]
	data.planted_crop = crop
	
	var i_crop : Crop = l_crop.instantiate()
	i_crop.cell_data = data
	i_crop.global_position = map_to_local(data.coords)
	add_child(i_crop)
