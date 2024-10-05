class_name CellData
extends Node

var coords
var has_creature : bool = false
var creature : Creature
var planted_crop : String = ""
var crop : Crop
var health : int = 3
var stage = 0

func _process(delta: float) -> void:
	if health <= 0:
		stage = 3

func harvest() -> int:
	print(crop)
	var earned_coins : int = 0
	if stage < 2:
		return 0
	if stage == 2:
		earned_coins += crop.harvest()
	if stage > 2:
		crop.harvest()
	
	stage = 0
	planted_crop = ""
	health = 3
	
	return earned_coins

func attackable() -> bool:
	return (planted_crop != "") and (not has_creature) and (stage != 3)

func _to_string() -> String:
	return "{" + str(coords) + " : " + "has_creature: " + str(has_creature) + ", plant: " + planted_crop + "}" 
