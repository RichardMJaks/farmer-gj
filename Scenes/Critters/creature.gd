class_name Creature
extends AnimatableBody2D

var cell_data : CellData
var target_tile : Vector2

var getting_kicked : bool = true

func _ready() -> void:
	cell_data.creature = self
	_tween_to_position()

func _tween_to_position() -> void:
	var tween : Tween = create_tween()
	tween.tween_property(self, "position", target_tile, 5)
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(func(): 
		$Node/FirstStrikeTimer.start()
		cell_data.has_creature = true
	)

func _process(delta: float) -> void:
	if cell_data.health == 0 or cell_data.planted_crop == "":
		if cell_data.health == 0:
			cell_data.stage = 3
		cell_data.has_creature = false
		var tween : Tween  = create_tween()
		tween.tween_property(self, "position", _get_exit_pos(), 1)\
			.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
		tween.tween_callback(queue_free)

func get_kicked(player : CharacterBody2D) -> void:
	$Node/HitTimer.paused = true
	$Node/FirstStrikeTimer.paused = true
	var kick_direction = (global_position - player.global_position).normalized() * 300
	var tween : Tween = create_tween()
	cell_data.has_creature = false
	tween.tween_property(self, "global_position", position + kick_direction, 3).set_ease(Tween.EASE_OUT)
	# tween.parallel().tween_property(self, "rotation_degrees", 1080, 3).set_ease(Tween.EASE_OUT)
	tween.tween_callback(queue_free)
	 
	
func _get_exit_pos() -> Vector2:
	return Vector2(100, 100)

#TODO: Make tween correct
#TODO: Handle shit correctly ff
func _tween_hit() -> void:
	if getting_kicked:
		return
	var tween : Tween = create_tween()
	tween.tween_property(self, "rotation_degrees", 60, 0.2)
	tween.tween_callback(func():
		cell_data.health -= 1
		print("Hit cell " + str(cell_data.coords) + "| Health: " + str(cell_data.health))
		var twen = create_tween()
		twen.tween_property(self, "rotation_degrees", 0, 0.5)
		twen.tween_callback($Node/HitTimer.start)
	)

#TODO: remove autostart, tween in
func _on_first_strike_timer_timeout() -> void:
	_tween_hit()


func _on_hit_timer_timeout() -> void:
	if not cell_data.health == 0:
		_tween_hit()
