extends Node2D

var critter_ps : PackedScene = preload("res://Scenes/Characters/Critters/critter.tscn")
@export var spawn_protected: Vector2 = Vector2(120, 150)

var critters: Array[Critter] = []

func _ready() -> void:
	pass


func _summon_creature() -> void:
	var cell = _select_random_plant()
	if cell == null:
		return
	var critter = _instantiate_critter(cell)
	add_child(critter)


func _select_random_plant() -> CropCell:
	var critter_cells : Array = GM.critter_etml.targeted_crops
	var crop_cells : Dictionary = GM.crop_etml.get_cells()
	
	# XOR the cells
	for cell : Vector2i in critter_cells.map(func(c): return c.get_coords()):
		crop_cells.erase(cell)
	
	# Filter out rotted plants
	for key in crop_cells.keys():
		var cell = crop_cells[key]
		#HACK: required to avoid previously freed instance error
		#if not is_instance_valid(cell):
		#	crop_cells.erase(key)
		#w	continue
		
		if cell.rotted:
			crop_cells.erase(key)
	
	if crop_cells.is_empty():
		return null
	
	return crop_cells[crop_cells.keys().pick_random()]

func _instantiate_critter(cell : CropCell) -> Critter:
	var critter : Critter = critter_ps.instantiate()
	critter.set_crop(cell)
	
	# Get spawn direction
	var spawn_direction: Vector2 = Vector2(1, 0).rotated(randf_range(0, 360))
	
	# Extend it to spawn protected bound
	var spawn: Vector2 = spawn_protected * spawn_direction * 1.1
	critter.global_position = spawn
	GM.critter_etml.target_crop(critter, cell)
	return critter
	

#TODO: Tweak timeout functionality
func _on_creature_timer_timeout() -> void:
	_summon_creature()
