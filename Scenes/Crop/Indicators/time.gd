extends Indicator

@onready var timer : Timer
@onready var anim : AnimationPlayer = $AnimationPlayer
var start_frame : int = 9

func enter() -> void:
	visible = true

func exit() -> void:
	visible = false

func update() -> void:
	var t_d = timer.wait_time / 3
	var frame_delta = 0
	if timer.time_left < t_d * 2:
		frame_delta += 1
	if timer.time_left < t_d:
		frame_delta += 1
		
	frame = start_frame + frame_delta
	anim.speed_scale = frame_delta + 1
