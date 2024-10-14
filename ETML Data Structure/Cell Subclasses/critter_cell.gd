class_name CritterCell
extends Cell

var _critter : Critter = null

func set_critter(critter : Critter, crop : CropCell) -> Critter:
	_critter = critter
	_critter._cell = self
	_critter.set_crop(crop)
	_tml.add_child(_critter)
	return _critter

func hit_critter(c : CharacterBody2D) -> void:
	_critter.take_damage(c)
	queue_free()

func get_critter() -> Critter:
	return _critter

func get_type():
	return CritterCell
