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
var state = STATE.BUYABLE
enum STATE {
	BUYABLE,
	CARRIED, 
	PLANTED
}

func _ready() -> void:
	price_tag.text = str(price)
	_update_state_appearance()

func _process(_delta: float) -> void:
	planted_sprite.frame = _start_frame + _stage

#TODO: Harvest flair
func harvest() -> int:
	queue_free()
	return _value

#region States
func change_state(new_state : STATE) -> int:
	state = new_state
	
	_update_state_appearance()
	
	return state

func _update_state_appearance() -> void:
	match(state):
		STATE.BUYABLE:
			_set_state_buyable()
		STATE.CARRIED:
			_set_state_carried()
		STATE.PLANTED:
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

func _on_stage_timer_timeout() -> void:
	if _stage == 2:
		rot()
	_grow()
	#TODO: Maybe make ripe phase last longer than growth?
	# if _stage == 3:
	#	 set_some_var_to_true
	#	loop stage_timer once more to lengthen, this time showing timer indicators
	

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
