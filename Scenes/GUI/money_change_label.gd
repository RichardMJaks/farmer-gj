extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self, "position", position - 30 * Vector2.UP, 1)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property(self, "modulate:a", 0, 1)\
	.set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(queue_free)
