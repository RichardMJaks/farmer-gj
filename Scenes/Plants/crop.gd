class_name Crop
extends Node2D

var cell_data
@export var start_frame : int
@export var value : int = 0

@onready var sprite : Sprite2D = $Sprite

func harvest() -> int:
	return value

func _on_next_stage_timer_timeout() -> void:
	if cell_data.stage < 4:
		cell_data.stage += 1
		sprite.frame = start_frame + cell_data.stage
	else:
		$NextStageTimer.stop()
