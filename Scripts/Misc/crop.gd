class_name Crop
extends Node2D

@export var crop_name : String = ""

@onready var planted_sprite : Sprite2D = $PlantedSprite
@onready var buy_carry_sprite : Sprite2D = $BuyCarrySprite
@onready var price_tag : Label = $BuyCarrySprite/PriceTag

var _cell : SoilCell 

# Planted variables
var _stage_growth_time : float
var _stage : int
var _harvestable : bool = false

# Buyable variables
var price : int = 0
var icon : Resource

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

#TODO: Add _process() functionality
func _process(_delta: float) -> void:
	pass

#TODO: Add harvest() functionality
func harvest() -> int:
	return -1

#TODO: Add take_damage() functionality
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

#TODO: Test _set_state_buyable()
func _set_state_buyable() -> void:
	print_debug("Crop is buyable")
	
	planted_sprite.visible = false
	buy_carry_sprite.visible = true
	price_tag.visible = true

#TODO: Test _set_state_carried()
func _set_state_carried() -> void:
	print_debug("Crop is carried")
	
	planted_sprite.visible = false
	buy_carry_sprite.visible = true
	price_tag.visible = false

#TODO: Test _set_state_planted()
func _set_state_planted() -> void:
	print_debug("Crop is planted")
	
	planted_sprite.visible = true
	buy_carry_sprite.visible = false
	price_tag.visible = false
#endregion

#TODO: Add timer timeout functionality
func _on_next_stage_timer_timeout() -> void:
	pass

func _to_string() -> String:
	return crop_name
