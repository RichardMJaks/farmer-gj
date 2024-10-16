extends State

@export var idle : State

func enter() -> void:
	anim.play("kick")
	anim.animation_finished.connect(state_changed.emit.bind(self, idle))

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
