class_name Crop
extends Node2D

var _cell : SoilCell 
var _stage_growth_time : float
var _harvestable : bool = false
var price : int = 0
var icon : Resource

# States mostly apply to how crop appears
# States:
# - buyable
# - carried
# - planted
var state = "buyable"

#TODO: Add _process() functionality
func _process(_delta: float) -> void:
	pass

#TODO: Add harvest() functionality
func harvest() -> int:
	return -1

#TODO: Add take_damage() functionality
func take_damage() -> void:
	pass

#TODO: Add timer timeout functionality
func _on_next_stage_timer_timeout() -> void:
	pass
