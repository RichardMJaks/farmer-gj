extends Node2D

var critter_ps : PackedScene = preload("res://Scenes/Critters/critter.tscn")

func _ready() -> void:
	pass


func _summon_creature() -> void:
	var cell = _select_random_plant()
	if cell == null:
		return
	var critter = _instantiate_critter(cell)
	GM.critter_etml.target_crop(cell, critter)


func _select_random_plant() -> CropCell:
	var critter_cells : Array = GM.critter_etml.cells.keys()
	var crop_cells : Dictionary = GM.crop_etml.cells
	var crop_cells_keys : Array = crop_cells.keys()
	
	# XOR the cells
	for cell : Vector2i in critter_cells:
		crop_cells_keys.erase(cell)
	
	# Filter out rotted plants
	for cell in crop_cells.values():
		#HACK: required to avoid previously freed instance error
		if not is_instance_valid(cell):
			continue
		
		if cell.rotted:
			crop_cells_keys.erase(cell.get_coords())
	
	if crop_cells_keys.is_empty():
		return null
	return crop_cells[crop_cells_keys.pick_random()]

func _instantiate_critter(cell : CropCell) -> Critter:
	var critter : Critter = critter_ps.instantiate()
	critter.set_crop(cell)
		
	return critter
	

#TODO: Tweak timeout functionality
func _on_creature_timer_timeout() -> void:
	_summon_creature()
