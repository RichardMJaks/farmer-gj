class_name Seed
extends Node2D

@export var seed_name : String = ""
@export var crop : PackedScene
var display_price = true
var cell_data : CellData

func _ready() -> void:
	$Label.text = str(cell_data.price)
	
func stop_price_display():
	display_price = false
	$Label.visible = false
