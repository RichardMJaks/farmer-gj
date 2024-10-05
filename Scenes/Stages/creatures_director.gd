extends Node2D

@onready var soil_tml : SoilTileMapLayer = $"../TileMap/Soil"
@export var c_raven : PackedScene


#TODO: make summoning choose randomly
#TODO: Director algorithm
#TODO: Difficulty curve
func _summon_creature() -> void:
	var cell_data : CellData = _select_random_plant()
	if not cell_data:
		return
	
	var inst : Creature = c_raven.instantiate()
	inst.cell_data = cell_data
	inst.target_tile = soil_tml.map_to_local(cell_data.coords)
	add_child(inst)
	
	
func _select_random_plant() -> CellData:
	var cells = soil_tml.get_attackable_cells()
	if cells.size() == 0:
		return null
	return cells.pick_random()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_creature_timer_timeout() -> void:
	pass # Replace with function body.
