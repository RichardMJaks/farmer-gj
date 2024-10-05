class_name Crop
extends Node2D

var cell_data
@export var start_frame : int
@export var value : int = 0

@onready var sprite : Sprite2D = $Sprite

func _process(delta: float) -> void:
	sprite.frame = start_frame + cell_data.stage

#TODO: Earning money, buying seeds
func harvest() -> int:
	var tween = create_tween()
	tween.tween_property(self, "scale", 0, 0.5)
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tween.tween_callback(queue_free)
	return value

func _on_next_stage_timer_timeout() -> void:
	if cell_data.stage < 4:
		cell_data.stage += 1
	else:
		$NextStageTimer.stop()
