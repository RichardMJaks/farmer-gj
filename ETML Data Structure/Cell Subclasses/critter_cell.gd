class_name CritterCell
extends Cell

var _critter : Critter = null

func set_critter(critter : Critter) -> Critter:
	_critter = critter
	_critter.cell = self
	return _critter

func hit_critter(c : CharacterBody2D) -> void:
	_critter.take_damage(c)
	_remove()

func get_critter() -> Critter:
	return _critter

func get_type():
	return CritterCell
