class_name CellData
extends Node

var coords
var has_creature : bool = false
var plant : String = ""

func _to_string() -> String:
	return "{" + str(coords) + " : " + "has_creature: " + str(has_creature) + ", plant: " + plant + "}" 
