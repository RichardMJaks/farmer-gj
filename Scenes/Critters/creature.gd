class_name Creature
extends AnimatableBody2D

var cell_data : CellData

func _process(delta: float) -> void:
	if cell_data.health == 0:
		var tween : Tween  = create_tween()
		tween.tween_property(self, "position", _get_exit_pos(), 1)
		tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		tween.tween_callback(queue_free)
	
func _get_exit_pos() -> Vector2:
	return Vector2(100, 100)

#TODO: Make tween correct
#TODO: Handle shit correctly ff
func _tween_hit() -> void:
	var tween : Tween = create_tween()
	tween.tween_property(self, "rotation_degrees", 60, 0.2)
	tween.tween_callback(func():
		cell_data.health -= 1
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
