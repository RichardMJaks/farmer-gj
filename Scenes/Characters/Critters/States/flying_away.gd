extends State

func enter() -> void:
	audio_player.play("fly")
	char.velocity = Vector2.from_angle(randf() * 10) * 100
	
	if char.cell:
		char.cell._remove()

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if char.global_position.length() > 250:
			char.queue_free()

func physics_update(_delta: float) -> void:
	pass
