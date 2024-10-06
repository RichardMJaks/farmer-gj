extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameMaster.init_game()
	GameMaster.HUD = $HUD


func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()
