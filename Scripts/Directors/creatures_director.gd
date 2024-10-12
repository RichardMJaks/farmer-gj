extends Node2D

var soil_etml : SoilETML
var critter : Critter

func _ready() -> void:
	pass

#TODO: Make creature summoning
func _summon_creature() -> void:
	pass

#TODO: Make random plant selection
func _select_random_plant() -> SoilCell:
	return null

#TODO: Add timeout functionality
func _on_creature_timer_timeout() -> void:
	pass
