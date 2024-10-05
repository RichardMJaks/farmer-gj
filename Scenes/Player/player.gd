extends CharacterBody2D


@export var speed : float
@export var acceleration_time : float

@onready var soil_tml : SoilTileMapLayer = $"../TileMap/Soil"
@onready var anim : AnimationPlayer = $AnimationPlayer

var actionable_tile : CellData

func _process(delta: float) -> void:
	_get_actionable_tile()
	#TODO: Add action detection, make actions possible
	if Input.is_action_just_pressed("a_action"):
		_action()

func _action() -> void:
	if not actionable_tile:
		print("Not actionable")
		return
	if actionable_tile.has_creature:
		print("Hitting creature")
		_hit()
		return
	if actionable_tile.planted_crop == "":
		print("Planting")
		_plant()
	else:
		print("harvesting")
		_harvest()

#TODO: Action: Hitting
func _hit() -> void:
	pass

#TODO Action: planting
func _plant() -> void:
	soil_tml.plant("eggplant", actionable_tile)

func _harvest() -> void:
	actionable_tile.harvest()

#TODO: Action: buying
func _buy() -> void:
	pass

#TODO: Add inventory?

func _physics_process(delta: float) -> void:
	var h_dir : float = Input.get_axis("m_left", "m_right")
	var v_dir : float = Input.get_axis("m_up", "m_down")
	
	var dir_vec : Vector2 = Vector2(h_dir, v_dir).normalized()
	
	if dir_vec.length() != 0:
		velocity = dir_vec * speed
		anim.play("walking")
	else:
		velocity = Vector2.ZERO
		anim.play("idle")

	move_and_slide()

func _get_actionable_tile() -> CellData:
	actionable_tile = soil_tml.c_get_cell_data(soil_tml.local_to_map(position))
	return actionable_tile
