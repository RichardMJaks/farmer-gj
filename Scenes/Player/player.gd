extends CharacterBody2D


@export var speed : float
@export var acceleration_time : float

@onready var soil_tml : SoilTileMapLayer = $"../TileMap/Soil"

var actionable_tile : CellData

func _process(delta: float) -> void:
	_get_actionable_tile()
	if Input.is_action_just_pressed("a_action"):
		actionable_tile.plant = "rose"
	


func _physics_process(delta: float) -> void:
	var h_dir : float = Input.get_axis("m_left", "m_right")
	var v_dir : float = Input.get_axis("m_up", "m_down")
	
	var dir_vec : Vector2 = Vector2(h_dir, v_dir).normalized()
	
	if dir_vec.length() != 0:
		velocity = dir_vec * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _get_actionable_tile() -> CellData:
	actionable_tile = soil_tml.c_get_cell_data(soil_tml.local_to_map(position))
	print(soil_tml.c_get_cell_data(soil_tml.local_to_map(position)))
	return actionable_tile
