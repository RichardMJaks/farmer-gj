class_name CellData
extends Node

# Soil vars
var coords
var has_creature : bool = false
var creature : Creature
var planted_crop : String = ""
var crop : Crop
var health : int = 1
var stage = 0

# Shop vars
var is_shop : bool = false
var seed : Seed
var price : int = 0
var is_sell : bool = false

func set_creature(c : Creature) -> void:
	creature = c

func take_damage() -> void:
	if not crop:
		return
	health -= 1
	crop.take_damage()

func harvest() -> int:
	var measure_stage = stage
	
	stage = 0
	planted_crop = ""
	health = 1
	
	if measure_stage == 2:
		return crop.harvest()
	else:
		crop.harvest()
	return 0

func buy(player : CharacterBody2D) -> Seed:
	GameMaster.remove_money(price)
	seed.display_price = false
	player.held_crop = seed
	
	var seed_ref = seed
	seed = null
	
	return seed_ref

func attackable() -> bool:
	return (planted_crop != "") and (not has_creature) and (stage != 3) and (not is_shop)

func is_dead() -> bool:
	return (stage > 2) or (health <= 0) or (planted_crop == "")
		

func _to_string() -> String:
	return "{" + str(coords) + " : " + "has_creature: " + str(has_creature) + ", plant: " + planted_crop + "}" 
