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
	cell_data.has_creature = true
	inst.cell_data = cell_data
	inst.global_position = soil_tml.map_to_local(cell_data.coords)
	add_child(inst)
	
	
func _select_random_plant() -> CellData:
	var cell_data = null
	var cell_datas = soil_tml.grid_data.values()
	var selected = null
	var tested : Array[int] = []
	var l_cell_datas = cell_datas.size()
	while !selected or tested.size() >= (l_cell_datas - 1):
		print("While")
		var rng = randi_range(0, l_cell_datas - 1)
		while tested.has(rng):
			print("while rng")
			rng = randi_range(0, l_cell_datas - 1)
			if tested.size() >= (l_cell_datas - 1):
				break
		tested.append(rng)
		var t_cell_data = cell_datas[rng]
		if t_cell_data.plant != "" and not t_cell_data.has_creature:
			cell_data = t_cell_data
			break
	
	return cell_data
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
