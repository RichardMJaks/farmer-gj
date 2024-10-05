extends CharacterBody2D


@export var speed : float
@export var acceleration_time : float


func _physics_process(delta: float) -> void:
	var h_dir : float = Input.get_axis("m_left", "m_right")
	var v_dir : float = Input.get_axis("m_up", "m_down")
	
	var dir_vec : Vector2 = Vector2(h_dir, v_dir).normalized()
	
	if dir_vec.length() != 0:
		velocity = _get_clamped_velocity(dir_vec)
		
	move_and_slide()

func _get_clamped_velocity(v : Vector2) -> Vector2:
	var delta_acceleration = _calc_accel_from_time(acceleration_time) * v
	var new_velocity = velocity + delta_acceleration
	return new_velocity.clamp(Vector2(-speed, -speed), Vector2(speed, speed))
	

func _calc_accel_from_time(time : float) -> float:
	return speed / time
