class_name Cell
extends Node

var _coords : Vector2i

func set_coords(coords : Vector2i) -> Vector2i:
	_coords = coords
	return _coords

func get_coords() -> Vector2i:
	return _coords

func get_type():
	return "Cell"
