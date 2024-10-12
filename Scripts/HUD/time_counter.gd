extends Label


func _process(delta: float) -> void:
	var time = GameMaster.remaining_time
	time = ceili(time)
	var time_str = str(time)
	if time < 10:
		time_str = "0" + time_str
	
	text = time_str
	
