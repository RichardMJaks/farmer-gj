extends State

func enter() -> void:
	GM.critter_etml.targeted_crops.erase(owner._crop)
	owner.velocity = dir * 300
	anim.play("get_kicked")

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
