extends CharacterBody2D

#TODO: Add single crop at a time

@export var speed : float
@export var acceleration_time : float

@onready var state_machine : Node = $StateMachine
@onready var sprite_marker : Marker2D = $Sprite

@onready var crop_position : Vector2 = $CropPosition.position
var _crop : Crop

# IndicatorTML will set it itself
var indicator_tml : TileMapLayer = null

@onready var targeted_cell : Cell = null

@onready var boot : Sprite2D = $Sprite/Weapon/Boot
var facing_dir : float = 1

func _ready() -> void:
	if not indicator_tml:
		push_error("IndicatorTML not set! Is IndicatorTML present in scene?")

func _process(_delta : float) -> void:
	targeted_cell = _handle_indicator()
	
	if Input.is_action_just_pressed("a_action"):
		_context_action()

func _physics_process(_delta: float) -> void:
	_handle_movement()
	move_and_slide()

# Movement must be handled here, because otherwise it will be blocked due to state changes
# Will change if we want to override movement someday
# Future's problem tho
func _handle_movement() -> void:
	var h_dir : float = Input.get_axis("m_left", "m_right")
	var v_dir : float = Input.get_axis("m_up", "m_down")
	
	if h_dir < 0:
		facing_dir = -1
	if h_dir > 0:
		facing_dir = 1
	
	sprite_marker.scale.x = facing_dir
	
	var dir_vec : Vector2 = Vector2(h_dir, v_dir).normalized()
	
	if dir_vec.length() != 0:
		velocity = dir_vec * speed
	else:
		velocity = Vector2.ZERO

#region Indicator handling
func _handle_indicator() -> Cell:
	if not indicator_tml:
		return
	
	var tile_location : Vector2i = indicator_tml.local_to_map(position)
	var cell : Cell = indicator_tml.get_cell(tile_location)		
	
	if not cell or not _is_interactable(cell):
		return null
	
	indicator_tml.set_indicator(cell.get_coords())
	return cell

func _is_interactable(cell : Cell) -> bool:
	var cell_type = cell.get_type()
	match(cell_type):
		ShopCell: 
			return cell.get_crop() != null and _crop == null
		SoilCell: 
			return _crop != null
		SellCell: 
			return GM.has_uncollected_coins
		CropCell: 
			return cell.get_crop().harvestable
	
	return true
#endregion

#region Context Actions
func _context_action() -> void:
	if not targeted_cell:
		return
	match(targeted_cell.get_type()):
		ShopCell:
			_context_shop()
		SellCell:
			_context_sell()
		SoilCell:
			_context_soil()
		CropCell:
			_context_crop()
		CritterCell:
			_context_critter()


func _context_critter() -> void:
	if state_machine.current_state.name == "attacking":
		return
	state_machine.force_state_change("attacking")

func _ch_hit() -> void:
	var dir = boot.transform.x
	dir.x *= facing_dir
	dir.y *= -1
	targeted_cell.hit_critter(dir)	

#TODO: Sprite change to carrying when buying
func _context_shop() -> void:
	var crop = targeted_cell.buy_crop()
	
	if not crop:
		return
	
	_add_crop(crop)
	_crop.position = crop_position
	
	
#TODO: Sell flair
func _context_sell() -> void:
	targeted_cell.sell_crops()


func _context_crop() -> void:
	targeted_cell.harvest()


#TODO: Sprite change to regular when planted
func _context_soil() -> void:
	#TODO: Flair for when don't have crop to plant
	if not _crop:
		return
	
	remove_child(_crop)
	targeted_cell.plant(_crop)
	_crop = null
#endregion	


#region Helper functions
func _add_crop(crop : Crop) -> void:
	_crop = crop
	add_child(_crop)
#endregion
