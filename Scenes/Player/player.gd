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

@onready var audio_planting : AudioStreamPlayer = $Audio/Planting
@onready var audio_harvesting : AudioStreamPlayer = $Audio/Harvesting

func _process(_delta: float) -> void:
	_get_actionable_tile()
	if Input.is_action_just_pressed("a_action"):
		_action()
	
func _action() -> void:
	if not actionable_tile:
		return
	if actionable_tile.has_creature:
		_attack()
		return
	if actionable_tile.is_shop:
		_buy()
		return
	if actionable_tile.planted_crop == "" and held_crop:
		_plant()
	elif actionable_tile.stage > 1:
		_harvest()

#TODO: Action: Hitting
func _attack() -> void:
	state_machine.set_state("kicking")
	
func _hit() -> void:
	if not actionable_tile:
		return
	self.actionable_tile.creature.get_kicked(self)

#TODO Action: planting
func _plant() -> void:
	soil_tml.plant(held_crop, actionable_tile)
	audio_planting.play()

func _harvest() -> void:
	audio_harvesting.play()
	actionable_tile.harvest()	

#TODO: Action: buying
func _buy() -> void:
	pass

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
	
	var potential_actionable_tile = soil_tml.c_get_cell_data(soil_tml.local_to_map(position))
	
	if not potential_actionable_tile:
		return null
	
	if potential_actionable_tile.is_shop:
		return _set_actionable_tile(potential_actionable_tile)
	
	if potential_actionable_tile.has_creature:
		return _set_actionable_tile(potential_actionable_tile)
	
	if potential_actionable_tile.planted_crop != "" and potential_actionable_tile.stage > 1:
		return _set_actionable_tile(potential_actionable_tile)
	
	if potential_actionable_tile.planted_crop == "" and held_crop != "":
		return _set_actionable_tile(potential_actionable_tile)
		
	return null
	
func _set_actionable_tile(tile : CellData) -> CellData:
	actionable_tile = tile
	indicator_tml.move_indicator(tile.coords)
	return tile
