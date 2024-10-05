extends CharacterBody2D


@export var speed : float
@export var acceleration_time : float


func _physics_process(delta: float) -> void:
	var h_dir : float = Input.get_axis("m_left", "m_right")
	var v_dir : float = Input.get_axis("m_up", "m_down")
	
	var dir_vec : Vector2 = Vector2(h_dir, v_dir).normalized()
	
	if dir_vec.length() != 0:
		velocity = dir_vec * speed
	else:
		velocity = Vector2.ZERO
		
	print(velocity.length())
	move_and_slide()
