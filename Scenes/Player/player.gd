extends CharacterBody2D


@export var speed : float
@export var acceleration_time : float

@onready var soil_tml : SoilTileMapLayer = $"../TileMap/Soil"
# @onready var anim : AnimationPlayer = $AnimationPlayer
@onready var state_machine : Node = $StateMachine
@onready var sprite : Sprite2D = $Sprite
@onready var sprite_marker : Marker2D = $Marker2D
@onready var indicator_tml : TileMapLayer = $"../TileMap/Indicator"

var debug_chosen_crop = "wheat"
var actionable_tile : CellData

@onready var audio_planting : AudioStreamPlayer = $Audio/Planting
@onready var audio_harvesting : AudioStreamPlayer = $Audio/Harvesting

func _process(_delta: float) -> void:
	_get_actionable_tile()
	if Input.is_action_just_pressed("a_action"):
		_action()
	if Input.is_key_pressed(KEY_1):
		debug_chosen_crop = "wheat"
	if Input.is_key_pressed(KEY_2):
		debug_chosen_crop = "tomato"
	if Input.is_key_pressed(KEY_3):
		debug_chosen_crop = "eggplant"
	if Input.is_key_pressed(KEY_4):
		debug_chosen_crop = "pumpkin"

func _action() -> void:
	if not actionable_tile:
		return
	if actionable_tile.has_creature:
		_attack()
		return
	if actionable_tile.planted_crop == "":
		_plant()
	else:
		_harvest()

#TODO: Action: Hitting
func _attack() -> void:
	state_machine.set_state("kicking")
	
func _hit() -> void:
	self.actionable_tile.creature.get_kicked(self)

#TODO Action: planting
func _plant() -> void:
	soil_tml.plant(debug_chosen_crop, actionable_tile)
	audio_planting.play()

func _harvest() -> void:
	if actionable_tile.stage > 1:
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
	if state_machine.state == "kicking":
		return null
	actionable_tile = soil_tml.c_get_cell_data(soil_tml.local_to_map(position))
	indicator_tml.remove_indicator()
	if actionable_tile:
		indicator_tml.move_indicator(actionable_tile.coords)
	return actionable_tile
