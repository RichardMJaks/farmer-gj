extends CharacterBody2D


@export var speed : float
@export var acceleration_time : float

@onready var soil_tml : SoilTileMapLayer = $"../TileMap/Soil"
# @onready var anim : AnimationPlayer = $AnimationPlayer
@onready var state_machine : Node = $StateMachine
@onready var sprite_marker : Marker2D = $Marker2D
@onready var indicator_tml : TileMapLayer = $"../TileMap/Indicator"

var held_crop : Seed
var actionable_tile : CellData
var kick_tile : CellData

@onready var audio_planting : AudioStreamPlayer = $Audio/Planting
@onready var audio_harvesting : AudioStreamPlayer = $Audio/Harvesting

func _process(_delta: float) -> void:
	actionable_tile = _get_actionable_tile()
	if Input.is_action_just_pressed("a_action"):
		_action()
	
func _action() -> void:
	if not actionable_tile:
		return
	if actionable_tile.has_creature:
		_attack()
		return
	if actionable_tile.is_shop and actionable_tile.price <= GameMaster.money and actionable_tile.seed:
		_buy()
		return
	if actionable_tile.planted_crop == "" and held_crop:
		_plant()
	elif actionable_tile.stage > 1:
		_harvest()

#TODO: Action: Hitting
func _attack() -> void:
	kick_tile = actionable_tile
	state_machine.set_state("kicking")
	
func _hit() -> void:
	kick_tile.creature.get_kicked(self)
	kick_tile = null

#TODO Action: planting
func _plant() -> void:
	soil_tml.plant(held_crop, actionable_tile)
	held_crop.queue_free()
	held_crop = null
	audio_planting.play()

func _harvest() -> void:
	audio_harvesting.play()
	actionable_tile.harvest()	

#TODO: Action: buying
func _buy() -> void:
	var inst = actionable_tile.buy(self)
	soil_tml.remove_child(inst)
	add_child(inst)
	inst.stop_price_display()
	inst.position = Vector2.UP * 20

#TODO: Add inventory?

func _physics_process(_delta: float) -> void:
	var h_dir : float = Input.get_axis("m_left", "m_right")
	var v_dir : float = Input.get_axis("m_up", "m_down")
	
	if h_dir < 0:
		sprite_marker.scale.x = -1
	if h_dir > 0:
		sprite_marker.scale.x = 1
	
	var dir_vec : Vector2 = Vector2(h_dir, v_dir).normalized()
	
	if dir_vec.length() != 0:
		velocity = dir_vec * speed
		state_machine.set_state("walking")
	else:
		velocity = Vector2.ZERO
		state_machine.set_state("idle")

	move_and_slide()

func _get_actionable_tile() -> CellData:
	indicator_tml.remove_indicator()
	if state_machine.state == "kicking":
		return null
	
	var potential_actionable_tile : CellData = soil_tml.c_get_cell_data(soil_tml.local_to_map(position))
	
	if not potential_actionable_tile:
		return null
	
	if potential_actionable_tile.is_shop:
		if potential_actionable_tile.price <= GameMaster.money\
		and potential_actionable_tile.seed:
			return _set_actionable_tile(potential_actionable_tile)
		return null
	
	if potential_actionable_tile.has_creature:
		return _set_actionable_tile(potential_actionable_tile)
	
	if potential_actionable_tile.planted_crop != "" and potential_actionable_tile.stage > 1:
		return _set_actionable_tile(potential_actionable_tile)
	
	if potential_actionable_tile.planted_crop == "" and held_crop:
		return _set_actionable_tile(potential_actionable_tile)
		
	return null
	
func _set_actionable_tile(tile : CellData) -> CellData:
	indicator_tml.move_indicator(tile.coords)
	return tile
