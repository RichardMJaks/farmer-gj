extends State

@export var idle : State

func enter() -> void:
	anim.play("walking")

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	var dir = Input.get_axis("m_left", "m_right") * Vector2.RIGHT +\
		Input.get_axis("m_down", "m_up") * Vector2.UP
	
	if dir.length() == 0:
		state_changed.emit(self, idle)
