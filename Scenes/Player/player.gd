extends CharacterBody2D

#TODO: Add single crop at a time

@export var speed : float
@export var acceleration_time : float

@onready var state_machine : Node = $StateMachine
@onready var sprite_marker : Marker2D = $Sprite

@onready var crop_position : Vector2 = $CropPosition.position

# IndicatorTML will set it itself
var indicator_tml : TileMapLayer = null

@onready var targeted_cell : Cell = null

func _ready() -> void:
	if not indicator_tml:
		push_error("IndicatorTML not set! Is IndicatorTML present in scene?")

func _process(_delta : float) -> void:
	if not indicator_tml:
		return
	
	var tile_location : Vector2i = indicator_tml.local_to_map(position)
	targeted_cell = indicator_tml.get_cell(tile_location)		
	
	if Input.is_action_just_pressed("a_action"):
		_context_action()
	
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

#region Context Actions
func _context_action() -> void:
	if not targeted_cell:
		return
	match(targeted_cell.get_type()):
		"ShopCell":
			_context_shop()
		"SellCell":
			_context_sell()
		"SoilCell":
			_context_soil()
		"CropCell":
			_context_crop()
		"CreatureCell":
			_context_creature()

func _context_creature() -> void:
	print_debug("Creature")

func _context_shop() -> void:
	var crop = targeted_cell.buy_crop()
	
	if not crop:
		print_debug("failed buy")
		return
	
	add_child(crop)
	crop.position = crop_position
	
	print_debug("Shop")

func _context_sell() -> void:
	print_debug("Sell")

func _context_crop() -> void:
	print_debug("Crop")

func _context_soil() -> void:
	print_debug("Soil")

#endregion	
