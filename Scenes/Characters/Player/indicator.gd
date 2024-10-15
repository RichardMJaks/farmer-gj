extends TileMapLayer

func remove_indicator() -> void:
	var cells = get_used_cells()
	if cells:
		set_cell(get_used_cells()[0])

func move_indicator(coords : Vector2i) -> void:
	set_cell(coords, 0, Vector2i.ZERO)
	
