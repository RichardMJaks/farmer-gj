class_name Crop
extends Node2D

@export var crop_name : String = ""

@onready var planted_sprite : Sprite2D = $PlantedSprite
@onready var buy_carry_sprite : Sprite2D = $BuyCarrySprite

@onready var price_tag : Label = $BuyCarrySprite/PriceTag

var _cell : CropCell 

# Planted variables
@export var _start_frame = 0
var harvestable : bool = false
var _stage : int = 0
@export var _stage_growth_time : float = 5
@onready var stage_timer : Timer = (
	func() -> Timer:
		var timer = Timer.new()
		timer.wait_time = _stage_growth_time
		timer.one_shot = false
		timer.autostart = true
		timer.timeout.connect(_on_stage_timer_timeout)
		return timer
).call()

# Price stuff
@export var price : int = 0
@export var _value : int = 1
var icon : Resource # Is this necessary?

# States mostly apply to how crop appears
var state = STATE_BUYABLE
enum {
	STATE_BUYABLE,
	STATE_CARRIED, 
	STATE_PLANTED
}

func _ready() -> void:
	price_tag.text = str(price)
	_update_state_appearance()

#TODO: Add _process() functionality (Maybe not required)
func _process(_delta: float) -> void:
	planted_sprite.frame = _start_frame + _stage

#TODO: Harvest flair
func harvest() -> int:
	queue_free()
	return _value

#TODO: Add take_damage() functionality (maybe just rot)
func take_damage() -> void:
	pass

#region States
func change_state(new_state : int) -> int:
	state = new_state
	
	_update_state_appearance()
	
	return state

func _update_state_appearance() -> void:
	match(state):
		STATE_BUYABLE:
			_set_state_buyable()
		STATE_CARRIED:
			_set_state_carried()
		STATE_PLANTED:
			_set_state_planted()

#TODO: In-store animations
func _set_state_buyable() -> void:	
	planted_sprite.visible = false
	buy_carry_sprite.visible = true
	price_tag.visible = true

#TODO: Carry flair
func _set_state_carried() -> void:	
	planted_sprite.visible = false
	buy_carry_sprite.visible = true
	price_tag.visible = false

#TODO: Plant flair
func _set_state_planted() -> void:	
	planted_sprite.visible = true
	buy_carry_sprite.visible = false
	price_tag.visible = false
	
	add_child(stage_timer)
#endregion

#TODO: Add timer timeout functionality
func _on_stage_timer_timeout() -> void:
	_grow()
	#TODO: Maybe make ripe phase last longer than growth?
	# if _stage == 3:
	#	 set_some_var_to_true
	#	loop stage_timer once more to lengthen, this time showing timer indicators
	if _stage == 3:
		rot()

#TODO: Growth flair
func _grow() -> void:
	_stage += 1
	if _stage >= 2:
		harvestable = true

#TODO: Rot flair
func rot() -> void:
	_stage = 3
	_value = 0
	harvestable = true
	_cell.rotted = true
	stage_timer.stop()

func _to_string() -> String:
	return crop_name
