extends State

@export var idle : State

func enter() -> void:
	anim.play("kick")
	var ap_conns : Array = anim.animation_finished.get_connections()
	
	# Lets make sure we don't trigger anything else by accident
	if ap_conns.size() != 0:
		for conn : Dictionary in ap_conns:
			print(conn)
			anim.animation_finished.disconnect(conn["callable"])
	
	anim.animation_finished.connect(_finish.unbind(1))


func _finish() -> void:
	anim.animation_finished.disconnect(_finish)
	state_changed.emit.bind(self, idle)

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
