extends Node2D

@onready var soil_tml : SoilTileMapLayer = $"../TileMap/Soil"
@export var c_raven : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_summon_creature()

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
	return soil_tml.get_attackable_cells().pick_random()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
