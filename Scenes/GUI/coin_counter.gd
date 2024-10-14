extends Label

func _process(delta: float) -> void:
	text = _zero_padding_for_money()
	
func _zero_padding_for_money() -> String:
	var money : int = GM.coins
	var r_string = str(money)
	if money < 100:
		r_string = "0" + r_string
	if money < 10:
		r_string = "0" + r_string
	return r_string
