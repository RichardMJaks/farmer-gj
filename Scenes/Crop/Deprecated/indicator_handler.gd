extends Node2D

@onready var cell_data : CellData = $"..".cell_data
@onready var danger_arrow : Node2D = $DangerArrow
@onready var stage_timer : Timer = $"../NextStageTimer"

@onready var time : Node2D = $Time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for child in get_children():
		child.visible = false
	
	if cell_data.has_creature:
		danger_arrow.visible = true
		return
	if cell_data.stage == 2:
		_handle_time_indicators()

func _handle_time_indicators() -> void:
	time.visible = true
	var time_left = stage_timer.time_left
	var wait_time = stage_timer.wait_time
	
	if time_left < (wait_time / 3):
		time.set_frame(2)
	elif time_left < (2 * (wait_time / 3)):
		time.set_frame(1)
	else:
		time.set_frame(0)
