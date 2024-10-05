class_name Creature
extends CharacterBody2D

var cell_data : CellData
var target_tile : Vector2

@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var entry_tween : Tween = _create_entry_tween()
func _create_entry_tween() -> Tween:
	var tween = create_tween()
	tween.tween_property(self, "position", target_tile, 1)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_callback(_arrival)
	tween.stop()
	
	return tween

func _process(delta: float) -> void:
	if cell_data.is_dead():
		cell_data.stage = 3
		_leave()

func _arrival() -> void:
	$Node/FirstStrikeTimer.start()
	cell_data.has_creature = true
	cell_data.set_creature(self)
	entry_tween.kill()

func _ready() -> void:
	entry_tween.play()

func _attack() -> void:
	anim.play("hit")

func _hit() -> void:
	print("hitting")
	cell_data.take_damage()
	
func get_kicked(c : CharacterBody2D) -> void:
	$Node/FirstStrikeTimer.stop()
	var dir : Vector2 = (global_position - c.global_position).normalized()
	velocity = dir * 300
	anim.play("get_kicked")
	$Node/ExpirationTimer.start()

func _leave() -> void:
	var dir : Vector2 = Vector2.from_angle(randf_range(0, 2*PI))
	velocity = dir * 300
	$Node/FirstStrikeTimer.stop()
	$Node/ExpirationTimer.start()

func _on_first_strike_timer_timeout() -> void:
	_hit()

func _on_expiration_timer_timeout() -> void:
	queue_free()
