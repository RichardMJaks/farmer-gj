extends Node2D

var critter_ps : PackedScene = preload("res://Scenes/Critters/critter.tscn")

func _ready() -> void:
	pass

#TODO: Make creature summoning
func _summon_creature() -> void:
	var cell = _select_random_plant()
	if cell == null:
		return
	var critter = _instantiate_critter(cell)
	GM.critter_etml.target_crop(cell, critter)

#TODO: Make random plant selection
func _select_random_plant() -> CropCell:
	var critter_cells : Array = GM.critter_etml.cells.keys()
	var crop_cells : Dictionary = GM.crop_etml.cells
	
	# XOR the cells
	for cell : Vector2i in critter_cells:
		crop_cells.erase(cell)
	
	# Filter out rotted plants
	for cell : CropCell in crop_cells.values():
		if cell.rotted:
			crop_cells.erase(cell.get_coords())
	
	if crop_cells.is_empty():
		return null
	return crop_cells[crop_cells.keys().pick_random()]

func _instantiate_critter(cell : CropCell) -> Critter:
	var critter : Critter = critter_ps.instantiate()
	critter.set_crop(cell)
		
	return critter
	

#TODO: Add timeout functionality
func _on_creature_timer_timeout() -> void:
	_summon_creature()
