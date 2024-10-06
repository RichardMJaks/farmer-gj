extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameMaster.init_game()
	GameMaster.HUD = $HUD
	GameMaster.main_stage = self


func _game_over() -> void:
	var t =	$"Game End/Node2D/VBoxContainer/Time Survived/Label".text + str(ceili(GameMaster.total_time)) + " seconds"
	$"Game End/Node2D/VBoxContainer/Time Survived/Label".text = t
	t = $"Game End/Node2D/VBoxContainer/Crops Collected/Label".text + str(GameMaster.total_crops)
	$"Game End/Node2D/VBoxContainer/Crops Collected/Label".text = t
	t = $"Game End/Node2D/VBoxContainer/Critters Kicked/Label".text + str(GameMaster.kicked)
	$"Game End/Node2D/VBoxContainer/Critters Kicked/Label".text = t
	t = $"Game End/Node2D/VBoxContainer/Coins Earned/Label".text + str(GameMaster.total_money)
	$"Game End/Node2D/VBoxContainer/Coins Earned/Label".text = t
	$Music/SlowBG.stop()
	$Music/GameOver.play()
	$"Game End".visible = true
	$HUD.visible = false
	
	var tween : Tween  = $"Game End/Node2D".create_tween()
	tween.tween_property($"Game End/Node2D", "position:y", 0, 3)\
	.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)

func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()
