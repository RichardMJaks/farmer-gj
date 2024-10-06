class_name CellData
extends Node

# Soil vars
var coords
var has_creature : bool = false
var creature : Creature
var planted_crop : String = ""
var crop : Crop
var health : int = 3
var stage = 0

# Shop vars
var is_shop : bool = false
var seed : String = ""
var seed_sprite : Sprite2D
var price : int = 0

func set_creature(c : Creature) -> void:
	creature = c

func take_damage() -> void:
	if not crop:
		return
	health -= 1
	crop.take_damage()

func harvest() -> void:
	if stage == 2:
		GameMaster.money += crop.harvest()
	if stage > 2:
		crop.harvest()
	
	stage = 0
	planted_crop = ""
	health = 3

func attackable() -> bool:
	return (planted_crop != "") and (not has_creature) and (stage != 3) and (not is_shop)

func is_dead() -> bool:
	return (stage > 2) or (health <= 0) or (planted_crop == "")
		

func _to_string() -> String:
	return "{" + str(coords) + " : " + "has_creature: " + str(has_creature) + ", plant: " + planted_crop + "}" 
