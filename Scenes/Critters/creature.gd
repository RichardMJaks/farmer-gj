class_name Creature
extends CharacterBody2D

var cell_data : CellData
var target_tile : Vector2
var is_ded = false
@export var danger_arrow : PackedScene
var arrow_inst

@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var entry_tween : Tween = _create_entry_tween()
func _create_entry_tween() -> Tween:
	var tween = create_tween()
	tween.tween_property(self, "position", target_tile - Vector2(5, -5), 1)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_callback(_arrival)
	tween.stop()
	
	return tween

func _process(_delta: float) -> void:
	if cell_data.is_dead() and not is_ded:
		is_ded = true
		if cell_data.health <= 0:
			cell_data.stage = 3
		_leave()
	
	move_and_slide()

func _arrival() -> void:
	$Node/FirstStrikeTimer.start()
	cell_data.has_creature = true
	cell_data.set_creature(self)
	entry_tween.kill()

func _ready() -> void:
	entry_tween.play()
	$Sprite2D.frame = randi_range(0, 9)

func _attack() -> void:
	anim.play("hit")

func _hit() -> void:
	cell_data.take_damage()
	
	
func get_kicked(c : CharacterBody2D) -> void:
	is_ded = true
	$Node/FirstStrikeTimer.stop()
	var dir : Vector2 = (global_position - c.global_position).normalized()
	velocity = dir * 200
	anim.play("get_kicked")
	cell_data.has_creature = false
	cell_data.set_creature(null)
	$Node/ExpirationTimer.start()

func _leave() -> void:
	cell_data.has_creature = false
	cell_data.set_creature(null)
	anim.stop()
	var dir : Vector2 = Vector2.from_angle(randf_range(0, 2*PI))
	velocity = dir * 100
	$Node/FirstStrikeTimer.stop()
	$Node/ExpirationTimer.start()

func _on_first_strike_timer_timeout() -> void:
	_attack()

func _on_expiration_timer_timeout() -> void:
	queue_free()
