extends State

@export var walking : State

func enter() -> void:
	anim.play("idle")

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	var dir = Input.get_axis("m_left", "m_right") * Vector2.RIGHT +\
		Input.get_axis("m_down", "m_up") * Vector2.UP
	
	if dir:
		state_changed.emit(self, walking)
	
		
