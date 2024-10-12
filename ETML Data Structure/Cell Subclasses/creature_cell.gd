class_name CritterCell
extends Cell

var _critter : Critter = null

func set_critter(creature : Critter) -> Critter:
	_critter = creature
	return _critter
	
func get_critter() -> Critter:
	return _critter

func get_type():
	return "CritterCell"
