class_name CellData
extends Node

var coords
var has_creature : bool = false
var plant : String = "rose"
var health : int = 3
var stage = 0

func _to_string() -> String:
	return "{" + str(coords) + " : " + "has_creature: " + str(has_creature) + ", plant: " + plant + "}" 
