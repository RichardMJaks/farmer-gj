extends Node2D

@onready var soil_tml : SoilTileMapLayer = $"../TileMap/Soil"
@export var c_raven : PackedScene

func _ready() -> void:
	GameMaster.creatures_director = self

var nr_of_creatures_per_wave = 1

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
	inst.global_position = Vector2(150 * [1, -1].pick_random(), 200 * [1, -1].pick_random())

	get_tree().current_scene.add_child(inst)
	
func _select_random_plant() -> CellData:
	var cells = soil_tml.get_attackable_cells()
	if cells.size() == 0:
		return null
	return cells.pick_random()

func _on_creature_timer_timeout() -> void:
	for i in range(0, nr_of_creatures_per_wave):
		_summon_creature()
