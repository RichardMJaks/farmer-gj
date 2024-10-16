extends State

var dir: Vector2

func enter() -> void:
	GM.critter_etml.targeted_crops.erase(char._crop)
	char.velocity = dir * 300
	anim.play("get_kicked")

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if char.global_position.length() > 250:
			char.queue_free()

func physics_update(_delta: float) -> void:
	pass
