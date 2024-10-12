extends Label

@onready var player = $"../../Player"

func _process(delta: float) -> void:
	if player.held_money > 0:
		text = str(player.held_crops) + " CROPS = " + str(player.held_money) + " COINS"
	else:
		text = ""
