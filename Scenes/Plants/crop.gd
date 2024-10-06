class_name Crop
extends Node2D

var cell_data : CellData
@export var start_frame : int
@export var value : int = 0

@onready var sprite : Sprite2D = $Sprite
@onready var anim : AnimationPlayer = $AnimationPlayer

@onready var ind_arrow : Node2D = $Indicators/DangerArrow

var harvesting : bool = false

func _process(_delta: float) -> void:
	if harvesting:
		return
	sprite.frame = start_frame + cell_data.stage

#TODO: Earning money, buying seeds
func harvest() -> int:
	harvesting = true
	cell_data.planted_crop = ""
	cell_data.crop = null
	anim.play("harvest")
	anim.animation_finished.connect(queue_free.unbind(1))
	return value

func take_damage() -> void:
	anim.play("take_damage")

func _on_next_stage_timer_timeout() -> void:
	if cell_data.stage < 3:
		cell_data.stage += 1
	else:
		$NextStageTimer.stop()
